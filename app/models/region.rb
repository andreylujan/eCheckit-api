# == Schema Information
#
# Table name: regions
#
#  id            :integer          not null, primary key
#  name          :text             not null
#  roman_numeral :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  number        :integer
#

class Region < ActiveRecord::Base
    has_many :communes
end
