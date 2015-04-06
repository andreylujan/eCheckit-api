class AccessTokenSerializer < ActiveModel::Serializer
  attributes :token, :refresh_token, :expires_in, :revoked_at,
  :scopes
end
