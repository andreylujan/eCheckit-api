class AddSuggestionToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :suggestion, :text
  end
end
