class Movie < ActiveRecord::Base

	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :track_times
	belongs_to :user

	validates :title, presence: true, uniqueness: true
	validates :orig_title, uniqueness: true
end
