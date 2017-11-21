# -*- encoding : utf-8 -*-
class V2::DashboardController < ApplicationController

  before_action :doorkeeper_authorize!

  def duration_str(duration_secs)
    tmp = duration_secs
    duration_comps = []

    if duration_secs >= 86400
      days = (duration_secs/86400).to_i
      duration_comps << "#{days}d"
      duration_secs = duration_secs % 86400
    end
    if duration_secs >= 3600
      hours = (duration_secs/3600).to_i
      duration_comps << "#{hours}h"
      duration_secs = duration_secs % 3600
    end
    if duration_secs >= 60
      minutes = (duration_secs/60).to_i
      duration_comps << "#{minutes}m"
    elsif tmp < 60
      duration_comps << "#{duration_secs.to_i}s"
    end
    duration_comps.join(" ")
  end

  def show
    workspace = Workspace.find(params.require(:workspace_id))
    yearly_reports = workspace.reports
    .includes(:assigned_user, :creator)
    .where("reports.created_at >= ? AND reports.created_at < ?",
           DateTime.now.beginning_of_year, DateTime.now.end_of_year)
    .order('reports.created_at ASC')

    filtered_reports = yearly_reports

    last_month_reports = workspace.reports
    .includes(:assigned_user, :creator)
    .where("reports.created_at >= ? AND reports.created_at <= ?",
           DateTime.now.beginning_of_month - 1.month, DateTime.now.end_of_month - 1.month + 1)
    .order('reports.created_at ASC')

    reports_by_month = filtered_reports.group_by(&:month_criteria).map do |month|
      {
        num_assigned: month[1].count { |r| r.assigned_user.present? },
        num_executed: month[1].count { |r| r.finished? },
        month_name: I18n.l(month[0], format: '%B').capitalize

      }
    end

    current_month_user_reports = filtered_reports.where("reports.created_at >= ? AND reports.created_at <= ?",
                                                        DateTime.now.beginning_of_month, DateTime.now.end_of_month)
    .where.not(assigned_user_id: nil)

    current_month_reports_by_user = current_month_user_reports.group_by(&:assigned_user).map do |info|
      {
        user_name: info[0].name,
        num_assigned_reports: info[1].length,
        num_executed_reports: info[1].count { |r| r.finished? },
        average_duration: duration_str((info[1].inject(0) { |sum, x| sum + x.duration_seconds })/info[1].length)
      }
    end.sort! { |a, b| a[:user_name] <=> b[:user_name] }

    last_month_user_reports = last_month_reports
        .where.not(assigned_user_id: nil)

    last_month_reports_by_user = last_month_user_reports.group_by(&:assigned_user).map do |info|
      {
        user_name: info[0].name,
        num_assigned_reports: info[1].length,
        num_executed_reports: info[1].count { |r| r.finished? },
        average_duration: duration_str((info[1].inject(0) { |sum, x| sum + x.duration_seconds })/info[1].length)
      }
    end.sort! { |a, b| a[:user_name] <=> b[:user_name] }

    report_counts = {
      num_last_month: last_month_user_reports.count,
      num_current_month: current_month_user_reports.count
    }

    dashboard_info = {
      id: SecureRandom.uuid,
      report_counts: report_counts,
      reports_by_month: reports_by_month,
      last_month_reports_by_user: last_month_reports_by_user,
      current_month_reports_by_user: current_month_reports_by_user
    }


    render json: dashboard_info



  end

end
