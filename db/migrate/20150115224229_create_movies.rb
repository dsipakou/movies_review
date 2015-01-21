class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :orig_title
      t.string :year
      t.string :link
      t.string :image

      t.timestamps
    end
  end
end
