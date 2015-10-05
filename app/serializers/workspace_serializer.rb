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

class WorkspaceSerializer < ActiveModel::Serializer
    attributes :id, :name, :organization_id, :users, :report_counts,
    :current_contest, :server_time, :report_field_types

    has_many :reports
    has_many :report_states
    has_many :contests
    has_many :reasons
    has_many :channels

    def reports
        object_reports = object.reports.order('created_at desc')
        reports_json = []
        object_reports.each do |report|
            reports_json << ReportIndexSerializer.new(report).as_json
        end
        reports_json
    end

    def report_field_types
        types = []

        ordered = object.report_field_types.order 'index ASC'
        ordered.each do |o|
            if o.name == "reason"
                items = []
                reasons = object.reasons
                reasons.each do |reason|
                    items << {
                        title: reason.name,
                        image: reason.image,
                        id: reason.id
                    }
                end
                o.data["items"] = items
            elsif o.name == "channel"
                items = []
                channels = object.channels
                channels.each do |channel|
                    subitems = channel.subchannels.map { |s| s.name }
                    image = channel.image
                    if image.nil?
                        image = "/images/reports/channel_others.png"
                    end
                    items << {
                        title: channel.name,
                        image: image,
                        id: channel.id,
                        subitems: subitems
                    }         
                end
                o.data["items"] = items
            elsif o.widget.name == "checklist"
                checklist_id = o.data["checklist_id"]                
                checklist = object.checklists.where(id: checklist_id).first
                
                cats = checklist.checklist_categories
                categories = []
                cats.each do | category |
                    items = []
                    category.checklist_items.each do |item|
                        items << item.name
                    end
                    new_cat = {
                        name: category.name,
                        checklist_items: items
                    }      
                    categories << new_cat      
                end
                o.data = {
                    checklist_id: checklist_id,
                    name: checklist.name,
                    checklist_categories: categories
                }
            end
            types << ReportFieldTypeSerializer.new(o).as_json
        end
        types
    end

    def server_time
        DateTime.now.to_s
    end
end
