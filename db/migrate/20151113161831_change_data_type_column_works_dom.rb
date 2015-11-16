class ChangeDataTypeColumnWorksDom < ActiveRecord::Migration
  def change
  	change_column :works_doms, :client_id, 'integer USING CAST(client_id AS integer)'
  end
end
