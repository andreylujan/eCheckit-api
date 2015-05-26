# == Schema Information
#
# Table name: google_regions
#
#  id            :integer          not null, primary key
#  region        :text
#  google_region :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class GoogleRegion < ActiveRecord::Base
end
