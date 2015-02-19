class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie

	def self.get_comments_for_movie(movie)
		self.where(movie_id: movie)
	end
end
