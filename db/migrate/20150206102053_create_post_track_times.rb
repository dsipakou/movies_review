class CreatePostTrackTimes < ActiveRecord::Migration
  def change
    create_table :post_track_times do |t|
      t.references :user, index: true
      t.references :post, index: true
      t.datetime :view_time

      t.timestamps
    end
  end
end
