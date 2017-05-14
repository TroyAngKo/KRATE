class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.text :review
      t.boolean :recommend
      t.string :rated_by

      t.timestamps null: false
    end
  end
end
