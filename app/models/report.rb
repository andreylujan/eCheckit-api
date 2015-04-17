# == Schema Information
#
# Table name: reports
#
#  id               :integer          not null, primary key
#  creator_id       :integer          not null
#  assigned_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  report_state_id  :integer
#  workspace_id     :integer
#  venue_id         :integer
#  title            :text             not null
#  address          :text
#  city             :text
#  region           :text
#  commune          :text
#  country          :text
#  longitude        :float            not null
#  latitude         :float            not null
#  reference        :text
#  comment          :text
#

class Report < ActiveRecord::Base

	belongs_to :creator, foreign_key: :creator_id, class_name: :User
	belongs_to :assigned_user, foreign_key: :assigned_user_id, class_name: :User
    has_one :action
    has_many :pictures, dependent: :destroy
    accepts_nested_attributes_for :pictures
    belongs_to :report_state
    belongs_to :workspace
    belongs_to :venue
    has_many :report_fields

    validates_presence_of [ :workspace, :creator, 
    	:title, :longitude, :latitude ]
    	
    before_create :verify_state
    private
    def verify_state
        if report_state.nil?
            self.report_state = ReportState.find_by_workspace_id_and_name self.workspace_id, "Creado"
        end
    end
end
