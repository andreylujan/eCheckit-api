# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  comment    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rating     :integer          not null
#

class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :comment, :rating
end
