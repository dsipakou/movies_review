class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :limit => 20
      t.string :nickname, :limit => 20
      t.string :password_digest, :limit => 70

      t.timestamps
    end
  end
end
