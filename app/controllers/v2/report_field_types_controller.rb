class V2::ReportFieldTypesController < ApplicationController
  before_action :doorkeeper_authorize!

  def show
  end

  def index
    workspace = Workspace.find(params.require(:workspace_id))

    types = []

    ordered = workspace.report_field_types.order 'index ASC'
    ordered.each do |o|
      if o.name == "reason"
        items = []
        reasons = workspace.reasons
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
        channels = workspace.channels
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
        clients = workspace.clients
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
        constructions = Construction.joins(:client).where(clients: { workspace_id: workspace.id})
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
        contacts = Contact.joins(:construction => { :client =>  :workspace}).where(:workspaces => { :id => workspace.id })
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
      type = ReportFieldTypeSerializer.new(o).as_json
      type[:workspace_id] = workspace.id
      types << type
    end
    render json: types
  end
  

end
