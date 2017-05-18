class AddMovieAttributes < ActiveRecord::Migration
  def change
  	add_column :shows, :popularity, :float
  	add_column :shows, :vote_average, :float
  	add_column :shows, :release_date, :date
  	add_column :shows, :genres, :string
  	add_column :shows, :backdrop_path, :string
  end
end
