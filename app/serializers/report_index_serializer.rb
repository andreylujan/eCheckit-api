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
#

class ReportIndexSerializer < ActiveModel::Serializer
  attributes :id, :creator_id, :assigned_user_id,
  :created_at, :title, :workspace_id, :report_state_id,
  :assigned_at, :assigned_user_name, :creator_name
  has_one :report_state
  has_many :report_fields
  has_one :channel
  has_one :subchannel
  has_one :reason
end
