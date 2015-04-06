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
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :organization_users
  has_many :organizations, through: :organization_users
  has_many :created_reports, foreign_key: :creator_id, class_name: :Report
  has_many :assigned_reports, foreign_key: :assigned_user_id, class_name: :Report
  has_many :actions

  after_create :create_token

  def create_token
    app = doorkeeper_app
    if app
      Doorkeeper::AccessToken.create resource_owner_id: self.id, application_id: app.id
    end
  end

  def access_token
    access_tokens.last
  end
  
  def access_tokens
    Doorkeeper::AccessToken.where(resource_owner_id: id)
  end

  private

  def doorkeeper_app
  	@app ||= Doorkeeper::Application.find_by_name("echeckit")    
  end

end
