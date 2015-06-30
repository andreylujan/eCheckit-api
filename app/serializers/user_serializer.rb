# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :text             not null
#  last_name              :text
#  picture                :text
#  is_demo                :boolean          default(FALSE)
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :picture, :is_demo,
  :organizations, :admin_workspace_ids, :amazon_info

  has_one :access_token, serializer: AccessTokenSerializer

  def amazon_info
  	{
  		key: ENV["AMAZON_KEY"],
  		secret: ENV["AMAZON_SECRET"],
  		bucket: ENV["AMAZON_BUCKET"],
  		cdn: ENV["AMAZON_CDN"] 
  	}
  end

end
