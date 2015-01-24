class CreateTrackTimes < ActiveRecord::Migration
  def change
    create_table :track_times do |t|
      t.references :user, index: true
      t.references :movie, index: true
      t.datetime :review_view_time
      t.datetime :comment_view_time

      t.timestamps
    end
  end
end
