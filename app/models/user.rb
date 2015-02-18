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


	def admin?(username)
		#self.username.to_sym == username
	end

	def self.get_review_last_view_time(movie)
		self.find(movie.reviews.where.not(content: nil).last.user_id) unless movie.reviews.where.not(content: nil).last.nil?	
	end
end
