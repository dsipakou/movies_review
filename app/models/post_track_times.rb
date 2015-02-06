class PostTrackTimes < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def self.get_last_view(post_id, user_id)
  	PostTrackTimes.where({post_id: post_id, user_id: user_id})
  end
end
