class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :movie
      t.integer :parent_id
      t.references :user
      t.text :content

      t.timestamps
    end
  end
end
