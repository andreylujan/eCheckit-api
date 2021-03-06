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

class Feedback < ActiveRecord::Base
  belongs_to :user
  validates_presence_of [ :comment, :user, :rating ]
end
