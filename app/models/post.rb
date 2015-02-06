class Post < ActiveRecord::Base
	has_many :post_comments, :dependent => :destroy
	has_many :post_track_times
	belongs_to :user

  	validates :content, presence: true
end
