class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :user, index: true
      t.string :body
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
