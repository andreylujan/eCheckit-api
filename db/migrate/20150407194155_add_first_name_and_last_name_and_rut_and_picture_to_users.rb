class AddFirstNameAndLastNameAndRutAndPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :text, null: false
    add_column :users, :last_name, :text
    add_column :users, :rut, :text, null: false
    add_column :users, :picture, :text

    add_index :users, :rut, unique: true
  end
end
