class AddNumberToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :number, :integer
  end
end
