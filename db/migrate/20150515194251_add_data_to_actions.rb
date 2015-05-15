class AddDataToActions < ActiveRecord::Migration
  def change
    add_column :actions, :data, :json
  end
end
