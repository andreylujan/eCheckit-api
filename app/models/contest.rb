# == Schema Information
#
# Table name: contests
#
#  id                :integer          not null, primary key
#  workspace_id      :integer
#  starts_at         :datetime
#  ends_at           :datetime
#  prize_image       :text
#  tier_steps        :float            default([0.33, 0.66]), not null, is an Array
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  prize_description :text
#

class Contest < ActiveRecord::Base
  belongs_to :workspace

  validates_presence_of [ :workspace, :starts_at, :ends_at,
  	:tier_steps, :prize_description ]

  validate :valid_tiers

  def self.active_contest
    where("starts_at < ? and ends_at > ?", DateTime.now, DateTime.now).last
  end

  def is_active
    active_contest = Contest.active_contest
    self == active_contest
  end

  private
  def valid_tiers
  	if not(tier_steps.present? and tier_steps.length == 2 and 
  		tier_steps.all? {|i| i.is_a? Numeric and i < 1 and i > 0} and
  		tier_steps[0] < tier_steps[1])
  		errors.add(:tier_steps, "tier_steps debe ser un arreglo con dos porcentajes donde el primer " +
  			"elemento es menor que el segundo")
  	end
  end
end
