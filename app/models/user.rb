class User < ActiveRecord::Base
	
	has_secure_password

	validates :username, presence: true, uniqueness: true
	validates :nickname, presence: true, uniqueness: true
	validates :password, presence: true

	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :post_comments, :dependent => :destroy
	has_many :movies
	has_many :invites
	has_many :posts

	def self.get_movie_creator_nickname(movie)
		self.find(movie.user_id).nickname
	end

	def self.get_review_last_view_time(movie)
		self.find(movie.reviews.where.not(content: nil).last.user_id) unless movie.reviews.where.not(content: nil).last.nil?	
	end

	def self.user_has_no_review?(movie, user_id)
		movie.reviews.where(user_id: user_id).size == 0 || !movie.reviews.where(user_id: user_id).first.content?
	end

	def self.get_my_review(movie, user_id)
		movie.reviews.where(user_id: user_id)		
	end

	def self.get_other_reviews(movie, user_id)
		movie.reviews.where.not(user_id: user_id)
	end
end
