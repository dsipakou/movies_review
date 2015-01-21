class Review < ActiveRecord::Base
	belongs_to :movie
	belongs_to :user

	def self.find_by_user_and_movie(user, movie)
		Review.where("user_id = #{user} and movie_id = #{movie}")
	end
end
