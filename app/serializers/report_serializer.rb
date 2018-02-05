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
#  title            :text             not null
#  address          :text
#  city             :text
#  region           :text
#  commune          :text
#  country          :text
#  longitude        :float            default(0.0)
#  latitude         :float            default(0.0)
#  reference        :text
#  comment          :text
#  pdf              :text
#  reason_id        :integer
#  channel_id       :integer
#  subchannel_id    :integer
#  internal_id      :text             not null
#  start_date       :datetime
#  finish_date      :datetime
#  finish_latitude  :float
#  finish_longitude :float
#  visit_date       :datetime
#  start_latitude   :float
#  start_longitude  :float
#

class ReportSerializer < ActiveModel::Serializer
  attributes :id, :creator_id, :assigned_user_id, :assigned_user_name,:construction_id,
  :created_at, :workspace_id, :title, :address, :country, :commune, :pdf,
  :region, :city, :latitude, :longitude, :reference, :comment, :report_state_id,
  :creator_name, :synced, :internal_id, :is_draft, :start_date,
  :finish_date, :finish_latitude, :finish_longitude, :visit_date,
  :start_latitude, :start_longitude, :duration

  has_one :report_state
  has_many :pictures
  has_many :report_fields
  has_many :report_actions
  has_one :channel
  has_one :subchannel
  has_one :reason


  def synced
    1
  end

  def is_draft
    0
  end

end
