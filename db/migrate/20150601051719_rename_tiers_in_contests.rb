class RenameTiersInContests < ActiveRecord::Migration
  def change
  	rename_column :contests, :tiers, :tier_steps
  end
end
