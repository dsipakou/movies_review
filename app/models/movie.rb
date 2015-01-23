class Movie < ActiveRecord::Base
	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	belongs_to :user
end
