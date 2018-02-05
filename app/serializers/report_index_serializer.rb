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
#  longitude        :float            not null
#  latitude         :float            not null
#  reference        :text
#  comment          :text
#

class ReportIndexSerializer < ActiveModel::Serializer
  attributes :id, :creator_id, :assigned_user_id,:construction_id,
  :created_at, :title, :workspace_id, :report_state_id,
  :assigned_user_name, :creator_name, :pdf,
  :synced, :is_draft, :start_date, :finish_date, :visit_date,
  :internal_id, :client_name, :construction_name, :duration

  has_one :report_state
  has_one :channel
  has_one :subchannel
  has_one :reason

  def client_name
    client_field = object.report_fields.where(report_field_type_id: 15).first
    if client_field.present?
      client_field.value["name"]
    end
  end

  def construction_name
    construction_field = object.report_fields.where(report_field_type_id: 16).first
    if construction_field.present?
      construction_field.value["name"]
    end
  end

  def synced
    1
  end

  def is_draft
    0
  end

end
