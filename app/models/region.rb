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

    def self.find_by_name(name)
    	where("lower(unaccent(name)) = ?", I18n.transliterate(name).downcase).first
    end
end
