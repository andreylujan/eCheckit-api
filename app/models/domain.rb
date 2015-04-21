# == Schema Information
#
# Table name: domains
#
#  id                           :integer          not null, primary key
#  organization_id              :integer
#  domain                       :text             not null
#  default_email                :text             not null
#  allow_automatic_registration :boolean          default(TRUE), not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class Domain < ActiveRecord::Base
  belongs_to :organization

  validates_presence_of [ :organization, :domain, :default_email ]
  validates_uniqueness_of [ :default_email ], scope: :organization
  validates_uniqueness_of [ :domain ]

  before_save :downcase_attributes

  private
  def downcase_attributes
  	self.default_email.downcase!
  	self.domain.downcase!
  end
end
