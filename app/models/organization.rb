# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
    resourcify
	has_many :action_types, dependent: :nullify
    has_many :workspaces, dependent: :nullify
    has_many :venues, dependent: :nullify

    def users
        users = nil
        workspaces.each do |w|
            if users.nil?
                users = User.with_role(:user, w)
            else
                users = users + User.with_role(:user, w)
            end
        end
    end
end
