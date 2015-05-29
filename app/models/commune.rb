# == Schema Information
#
# Table name: communes
#
#  id         :integer          not null, primary key
#  region_id  :integer          not null
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Commune < ActiveRecord::Base
  belongs_to :region
end
