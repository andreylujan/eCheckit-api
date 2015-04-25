# == Schema Information
#
# Table name: report_field_types
#
#  id           :integer          not null, primary key
#  name         :text
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  widget_id    :integer
#  translations :json
#

require 'rails_helper'

RSpec.describe ReportFieldType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
