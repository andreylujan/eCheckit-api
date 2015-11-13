class DataPart

    include Mongoid::Document
    include Mongoid::Attributes::Dynamic

    field :name, type: String
    field :workspace_id, type: Integer

end