class RenameClientsDomsToClients < ActiveRecord::Migration
  def change
    rename_table :clients_doms, :clients
  end
end
