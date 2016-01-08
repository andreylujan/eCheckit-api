# == Schema Information
#
# Table name: workspaces
#
#  id                      :integer          not null, primary key
#  name                    :text
#  organization_id         :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  is_open                 :boolean          default(TRUE), not null
#  email                   :text
#  welcome_message         :text
#  confirm_message         :text
#  max_pictures            :integer          default(20), not null
#  default_report_state_id :integer
#

class WorkspaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id, :users, :server_time,
    :report_field_types, :max_pictures

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
        clients = object.clients
        clients.each do |client|
          models << {
            client_id: client.id,
            name: client.name,
            client_rut: client.rut
          }
        end
        o.data["models"] = models
      elsif o.id == 16
        models = []
        constructions = Construction.joins(:client).where(clients: { workspace_id: object.id})
        constructions.each do |work|
          models << {
            works_id: work.id,
            construction_id: work.id,
            client_id: work.client_id,
            name: work.name,
            address: work.address
          }
        end
        o.data["models"] = models
      elsif o.name == "contact_table"
        models = []
        contacts = Contact.joins(:construction => { :client =>  :workspace}).where(:workspaces => { :id => object.id })
        contacts.each do |contact|
          models << {
            id: contact.id,
            construction_id: contact.construction_id,
            work_id: contact.construction_id,
            name: contact.name,
            email: contact.email,
            phone: contact.phone
          }
        end
        o.data["models"] = models
      end

      types << ReportFieldTypeSerializer.new(o).as_json
    end
    types
  end

  def server_time
    DateTime.now.to_s
  end
end
