class AddPrizeDescriptionToContests < ActiveRecord::Migration
  def change
    add_column :contests, :prize_description, :text
  end
end
