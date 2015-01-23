class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :movie
      t.references :user
      t.text :content
      t.integer :stars, :default => 0
      t.boolean :awesome

      t.timestamps
    end
  end
end
