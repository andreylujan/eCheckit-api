# == Schema Information
#
# Table name: widgets
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  structure  :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Widget < ActiveRecord::Base
	has_many :report_field_types
end
