class LoginController < ApplicationController
  def index
  	
  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		found_user = User.where(:username => params[:username]).first
  		if found_user
  			authorized_user = found_user.authenticate(params[:password])
  		end
  	end
  	if authorized_user
      session[:username] = authorized_user.username;
      session[:userid] = authorized_user.id;
      redirect_to index_path 	
  	else
      redirect_to login_path
    end

  end

  def logout
  	
  end
end
