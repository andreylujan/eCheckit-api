class AddUuidIndexToDevices < ActiveRecord::Migration
  def change
  	add_index :devices, :uuid, unique: true
  end
end
