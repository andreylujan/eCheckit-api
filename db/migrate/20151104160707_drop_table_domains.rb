class DropTableDomains < ActiveRecord::Migration
  def change
    drop_table :domains
  end
end
