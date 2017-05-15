class AddNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
  end
 
  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
