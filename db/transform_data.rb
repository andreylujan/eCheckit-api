
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


ap workspace_reasons

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

ap workspace_channels
# data_part = DataPart.new workspace_id: 1, name: 'channels'
# data_part[:value] = channels_collection


# ap data_part