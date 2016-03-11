# == Schema Information
#
# Table name: workspaces
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_open         :boolean          default(TRUE), not null
#

class Workspace < ActiveRecord::Base
  include ActiveModel::Serialization
  resourcify
  belongs_to :organization
  has_many :reports
  has_many :report_field_types
  has_many :report_states, dependent: :nullify
  has_many :workspace_invitations
  has_many :zone_assignments
  has_many :contests
  has_many :reasons
  has_many :channels
  has_many :checklists
  has_many :clients_doms
  after_create :create_default_states

  def report_counts
    contest = self.contests.last
    if contest.present?
      reports = self.reports.where("created_at > ? and created_at < ?", contest.starts_at, contest.ends_at)
      counts = reports.group(:creator_id).count
      counts_arr = []
      user_ids.each do |user_id|
        if counts[user_id].nil?
          counts[user_id] = 0
        end
      end
      counts.each do |k, v|
        counts_arr << {
          user_id: k,
          num_reports: v
        }

      end
      return counts_arr
    end
  end

  def local_dashboard(reports)
    reason_counts = {}
    state_counts = {}
    reports_count = reports.count

    self.report_states.each do |state|
      state_counts[state.name] = 0
    end

    reports.each do |report|
      if report.reason.present?
        reason_counts[report.reason.name] ||= {}
        reason_counts[report.reason.name][:total] ||= 0
        reason_counts[report.reason.name][:total] += 1
        reason_counts[report.reason.name][:states] ||= {}
        reason_counts[report.reason.name][:states][report.report_state.name] ||= 0
        reason_counts[report.reason.name][:states][report.report_state.name] += 1
      end
      if report.report_state.present?
        state_counts[report.report_state.name] ||= 0
        state_counts[report.report_state.name] += 1
      end
    end
    local = {
      reports_count: reports_count,
      reason_counts: reason_counts,
      state_counts: state_counts
    }
    return local
  end

  def dashboard_channel(year)
    reports = self.reports.where("created_at >= ? and created_at < ? and channel_id is not null", DateTime.new(year.to_i), DateTime.new(year.to_i + 1))
    grouped = reports.group_by { |i| i.created_at.month }
    sorted = grouped.sort
    data = []
    sorted.each do |month_group|
      month = month_group[0]
      reports = month_group[1]
      month_hash = {}
      channels = []
      channel_groups = reports.group_by { |r| r.channel.name }
      channel_groups.each do | channel_name, channel_reports |
        assigned = channel_reports.select { |r| r.report_state_id == 2 }
        num_assigned = assigned.size
        closed = channel_reports.select { |r| r.report_state_id == 27 }
        num_closed = closed.size
        channels << {
          channel_name: channel_name,
          num_assigned: num_assigned,
          num_closed: num_closed
        }
      end
      month_hash = {
        month: month,
        month_name: I18n.t("date.month_names")[month],
        channels: channels
      }
      data << month_hash
    end
    data
  end

  def dashboard_reason(year)
    reports = self.reports.where("created_at >= ? and created_at < ? and reason_id is not null", DateTime.new(year.to_i), DateTime.new(year.to_i + 1))
    grouped = reports.group_by { |i| i.created_at.month }
    sorted = grouped.sort
    data = []
    sorted.each do |month_group|
      month = month_group[0]
      reports = month_group[1]
      month_hash = {}
      reasons = []
      reason_groups = reports.group_by { |r| r.reason.name }
      reason_groups.each do | reason_name, reason_reports |
        assigned = reason_reports.select { |r| r.report_state_id == 2 }
        num_assigned = assigned.size
        closed = reason_reports.select { |r| r.report_state_id == 27 }
        num_closed = closed.size
        reasons << {
          reason_name: reason_name,
          num_assigned: num_assigned,
          num_closed: num_closed
        }
      end
      month_hash = {
        month: month,
        month_name: I18n.t("date.month_names")[month],
        reasons: reasons
      }
      data << month_hash
    end
    data
  end

  def dashboard(params = {})
    if self.organization_id == 1
      if params[:year] and params[:type]
        year = params[:year]
        if params[:type] == "channel"
          dashboard_channel(year)
        elsif params[:type] == "reason"
          dashboard_reason(year)
        end
      else
        reports = self.reports.where("channel_id is not null and reason_id is not null")


        if params[:start_date]
          begin
            start_date = Date.parse params[:start_date]
            reports = reports.where("created_at > ?", start_date)
          rescue ArgumentError
            return {
              error: "Invalid start_date"
            }
          end

        end
        if params[:end_date]
          begin
            end_date = Date.parse params[:end_date]
            reports = reports.where("created_at < ?", end_date)
          rescue ArgumentError
            return {
              error: "Invalid end_date"
            }
          end
        end

        global_info = local_dashboard(reports)
        regions = []
        channels = []
        states = []

        Region.all.each do |region|
          region_reports = reports.where("lower(unaccent(region)) = ?", I18n.transliterate(region.name).downcase)
          local_info = local_dashboard(region_reports)
          local_info[:region_id] = region.id
          local_info[:region_name] = region.name

          channel_info = []
          self.channels.each do |channel|
            data = {}
            channel_reports = region_reports.where(channel: channel)
            data = local_dashboard(channel_reports)
            data[:channel_id] = channel.id
            data[:channel_name] = channel.name
            channel_info << data
          end
          local_info[:channels] = channel_info
          regions << local_info
        end

        self.channels.each do |channel|
          channel_reports = reports.where(channel: channel)
          local_info = local_dashboard(channel_reports)
          local_info[:channel_id] = channel.id
          local_info[:channel_name] = channel.name
          channels << local_info
        end

        self.report_states.each do |report_state|
          state_reports = reports.where(report_state: report_state)
          states << {
            state_id: report_state.id,
            state_name: report_state.name,
            reports_count: state_reports.count
          }
        end

        global_info[:channels] = channels
        global_info[:regions] = regions
        global_info[:states] = states

        return global_info
      end
    end
  end

  def current_contest
    active_contest = self.contests.where("starts_at < ? and ends_at > ?", DateTime.now, DateTime.now).last
    if active_contest
      ContestSerializer.new(active_contest).as_json
    end
  end

  def user_ids
    invitations = self.workspace_invitations.where(accepted: true)
    invitations.pluck(:user_id)
  end

  def registered_users
    workspace_users = User.joins(:workspace_invitations).where("workspace_id = ? and accepted = ?", self.id, true).order(:id)
  end

  def users
    workspace_users = User.joins(:workspace_invitations).where("workspace_id = ?", self.id).order(:id)
    maps = workspace_users.map do |u|
      WorkspaceUserSerializer.new u
    end



    json = maps.as_json

    json.each do |u|
      invitation = WorkspaceInvitation.find_by_user_id_and_workspace_id u[:id], self.id
      if invitation.present? and invitation.accepted?
        u[:accepted] = true
        u[:pending] = false
      else
        u[:pending] = true
        u[:accepted] = false
      end
      if workspace_users.find_by_id(u[:id]).has_role? :admin, self
        u[:is_admin] = true
      else
        u[:is_admin] = false
      end
      u[:is_registered] = true
    end
    WorkspaceInvitation.where(user: nil, workspace: self).each do |unregistered|
      json << {
        email: unregistered.user_email,
        is_registered: false
      }
    end

    json
  end

  private
  def create_default_states
    ReportState.create workspace: self, name: "Creado"
    ReportState.create workspace: self, name: "Asignado"
  end
end
