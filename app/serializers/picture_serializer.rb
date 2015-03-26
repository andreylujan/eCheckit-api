# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  url        :text             not null
#  report_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PictureSerializer < ActiveModel::Serializer
  attributes :id, :url
  has_one :report
end
