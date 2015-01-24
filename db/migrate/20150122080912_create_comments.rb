class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :movie, index: true
      t.references :user, index: true
      t.integer :parent_id
      t.text :content

      t.timestamps
    end
  end
end
