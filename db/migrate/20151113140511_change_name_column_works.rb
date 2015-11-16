class ChangeNameColumnWorks < ActiveRecord::Migration
  def change
  	rename_column :works_doms, :client_id, :client_rut
  end
end
