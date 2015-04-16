# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  url        :text             not null
#  report_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment    :text
#

class PictureSerializer < ActiveModel::Serializer
  attributes :id, :url, :comment
end
