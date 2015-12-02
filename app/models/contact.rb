# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  work_id    :integer
#  name       :text
#  email      :text
#  phone      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
	belongs_to :construction, foreign_key: "work_id"
    before_validation :downcase_email

	validates_presence_of [ :email  ]
    validates_uniqueness_of [ :email ], scope: :work_id

    private
    def downcase_email
      self.email = self.email.downcase if self.email.present?
    end
end
