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

class DomainSerializer < ActiveModel::Serializer
	attributes :id, :domain, :default_email, :allow_automatic_registration
end
