class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :movie_id
      t.integer :user_id
      t.text :content
      t.integer :stars
      t.boolean :awesome

      t.timestamps
    end
  end
end
