# == Schema Information
#
# Table name: reports
#
#  id               :integer          not null, primary key
#  creator_id       :integer          not null
#  assigned_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ReportSerializer < ActiveModel::Serializer
  attributes :id, :creator_id, :assigned_user_id
end
