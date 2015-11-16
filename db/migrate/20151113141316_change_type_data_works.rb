class ChangeTypeDataWorks < ActiveRecord::Migration
  def change
  	change_column :works_doms, :client_rut, :text
  end
end
