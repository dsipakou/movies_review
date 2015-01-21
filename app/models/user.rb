class User < ActiveRecord::Base
	
	has_secure_password
	
	has_many :reviews

	def admin?(username)
		#self.username.to_sym == username
	end
end
