class TrackTimes < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  def self.get_last_view(movie_id, user_id)
  	TrackTimes.where({movie_id: movie_id, user_id: user_id})
  end
end
