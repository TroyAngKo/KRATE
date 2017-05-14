class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.text :description
      t.integer :rating
      t.text :review

      t.timestamps null: false
    end
  end
end
