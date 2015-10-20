# == Schema Information
#
# Table name: checklists
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :text
#

class Checklist < ActiveRecord::Base
    belongs_to :workspace
    has_many :checklist_categories, dependent: :destroy
    validates_presence_of [ :name, :workspace ]
    validates_uniqueness_of :name, scope: :workspace_id
    after_create :generate_report_field_type
    before_destroy :destroy_report_field_types
    before_save :capitalize_name


    private

    def capitalize_name
        self.name = self.name.capitalize
    end

    def generate_report_field_type
        workspace = self.workspace
        widget = Widget.find_or_create_by name: "checklist"
        ReportFieldType.create name: self.name,
        workspace: workspace, widget: widget,
        translations: {
            es: self.name,
            en: self.name
            },
            data: {
                checklist_id: self.id
            }
    end

        def destroy_report_field_types
            workspace = self.workspace
            workspace.report_field_types.each do |type|
                if type.data.present? and type.data["checklist_id"].present?
                    if type.data["checklist_id"] == self.id
                        type.destroy
                    end
                end
            end
        end

    end
