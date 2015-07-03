# == Schema Information
#
# Table name: reports
#
#  id               :integer          not null, primary key
#  creator_id       :integer          not null
#  assigned_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  report_state_id  :integer
#  workspace_id     :integer
#  venue_id         :integer
#  title            :text             not null
#  address          :text
#  city             :text
#  region           :text
#  commune          :text
#  country          :text
#  longitude        :float            not null
#  latitude         :float            not null
#  reference        :text
#  comment          :text
#  pdf              :text
#  reason_id        :integer
#  channel_id       :integer
#  subchannel_id    :integer
#

class ReportSerializer < ActiveModel::Serializer
  attributes :id, :creator_id, :assigned_user_id, :assigned_user_name,
  :created_at, :workspace_id, :title, :address, :country, :commune, :pdf,
  :region, :city, :latitude, :longitude, :reference, :comment, :report_state_id,
  :creator_name
  has_one :report_state
  has_many :pictures
  has_many :report_fields
  has_many :report_actions
  has_one :channel
  has_one :subchannel
  has_one :reason
end
