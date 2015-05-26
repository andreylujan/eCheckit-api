# == Schema Information
#
# Table name: google_communes
#
#  id             :integer          not null, primary key
#  commune        :text
#  google_commune :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class GoogleCommune < ActiveRecord::Base
end
