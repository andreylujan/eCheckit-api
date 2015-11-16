class ChangeNameColumnWorksDom < ActiveRecord::Migration
  def change
  	rename_column :works_doms, :client_rut, :client_id
  end
end
