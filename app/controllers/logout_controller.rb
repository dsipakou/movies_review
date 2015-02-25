class LogoutController < ApplicationController
	
  def index
	reset_session  	
  	redirect_to login_path
  end
end
