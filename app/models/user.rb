class User < ActiveRecord::Base
	
	has_secure_password
	
	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :movies

	def admin?(username)
		#self.username.to_sym == username
	end
end
