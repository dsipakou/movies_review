class LogoutController < ApplicationController
	
  def index
  	session[:userid] = nil
  	session[:username] = nil
  	redirect_to(login_path)
  end
end
