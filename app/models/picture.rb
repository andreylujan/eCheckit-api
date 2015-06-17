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

class Picture < ActiveRecord::Base

	require 'amazon'
	belongs_to :report

	after_destroy :amazon_destroy

	def key
		url[url.rindex(/\//) + 1..url.length - 1]
	end

	def amazon_destroy
		Amazon.delete_object(key)
	end
end
