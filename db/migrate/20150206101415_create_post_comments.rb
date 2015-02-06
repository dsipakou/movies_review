class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.integer :parent_id
      t.text :content

      t.timestamps
    end
  end
end
