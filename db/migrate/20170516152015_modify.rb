class Modify < ActiveRecord::Migration
  def change
  	remove_column :reviews, :title 
  	remove_column :reviews, :rated_by 
  	add_column :reviews, :movie_id, :integer
  	add_column :reviews, :user_id, :integer
  end
end
