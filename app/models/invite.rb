class Invite < ActiveRecord::Base
  belongs_to :user

  def self.get_all_invites_for_user(user)
  	self.where(user_id: user.id).order("used")
  end
end
