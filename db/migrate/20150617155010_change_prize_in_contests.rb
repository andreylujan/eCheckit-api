class ChangePrizeInContests < ActiveRecord::Migration
  def change
    rename_column :contests, :prize, :prize_image
  end
end
