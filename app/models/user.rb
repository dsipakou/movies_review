class User < ActiveRecord::Base
	
	has_secure_password

	validates :username, presence: true, uniqueness: true
	validates :nickname, presence: true, uniqueness: true
	validates :password, presence: true

	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :movies

	def admin?(username)
		#self.username.to_sym == username
	end
end
