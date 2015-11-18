
workspace_reasons = {}

Reason.all.each do |reason|
    w = reason.workspace
    workspace_reasons[w.id] ||= [] 
    workspace_reasons[w.id] << {
        _id: BSON::ObjectId.new,
        image: reason.image,
        name: reason.name
    }
end

# data_part = DataPart.new workspace_id: 1, name: 'reasons'
# data_part[:value] = reasons_collection

workspace_reasons.each do |key, value|
    d = DataPart.new workspace_id: key, name: 'reasons'
    d[:value] = value
end

# ap workspace_reasons

workspace_channels = {}

Channel.all.each do |channel|
    w = channel.workspace
    workspace_channels[w.id] ||= []

    channel_json = {
        _id: BSON::ObjectId.new,
        image: channel.image,
        name: channel.name
    }
    
    channel.subchannels.each do |sub|
        if not channel_json[:subitems]
            channel_json[:subitems] = []
        end
        channel_json[:subitems] << {
            _id: BSON::ObjectId.new,
            name: sub.name
        }
    end
    workspace_channels[w.id] << channel_json
end

workspace_channels.each do |key, value|
    d = DataPart.new workspace_id: key, name: 'channels'
    d[:value] = value
end

data_part = DataPart.new name: 'clients', workspace_id: 206
data_part[:value] = []
clients = {}

ClientsDom.all.each do |client|
    
    client_json = {
        _id: BSON::ObjectId.new,
        name: client.name,
        rut: client.rut
    }
    clients[client.id] = client_json[:_id]
    data_part[:value] << client_json
end

ap data_part

data_part = DataPart.new name: 'constructions', workspace_id: 206
data_part[:value] = []

works = {}
WorksDom.all.each do |work|

    work_json = {
        _id: BSON::ObjectId.new,
        name: work.name,
        address: work.address,
        client_id: clients[work.clients_dom.id]
    }
    works[work.id] = work_json[:_id]
    data_part[:value] << work_json
end

ap data_part

data_part = DataPart.new name: 'contacts', workspace_id: 206
data_part[:value] = []

ContactDom.all.each do |contact|

    contact_json = {
        _id: BSON::ObjectId.new,
        name: contact.name,
        email: contact.email,
        phone: contact.phone,
        construction_id: works[contact.works_dom.id]
    }
    data_part[:value] << contact_json
end

ap data_part


# ap workspace_channels
# data_part = DataPart.new workspace_id: 1, name: 'channels'
# data_part[:value] = channels_collection


# ap data_part