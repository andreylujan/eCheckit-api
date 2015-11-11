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
            elsif o.id == 15
                models = []
                clients_doms = object.clients_doms
                clients_doms.each do |client|
                    models << {
                        client_id: client.id,
                        workspace_id: client.workspace_id,
                        name: client.name,
                        client_rut: client.rut
                    }
                end
                o.data["models"] = models
            # elsif o.id == 16
            #     models = []
            #     works_doms = object.works_doms
            #     works_doms.each do |work|
            #         models << {
            #             works_id: work.id,
            #             client_id: work.client_id,
            #             work_name: work.name,
            #             address: work.rut
            #         }
            #     end
            #     o.data["models"] = models    
            end
                
            types << ReportFieldTypeSerializer.new(o).as_json
        end
        types
    end

    def server_time
        DateTime.now.to_s
    end
end
