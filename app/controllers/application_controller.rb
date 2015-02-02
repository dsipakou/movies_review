class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  config.i18n.default_locale = :ru

  def current_user
  	return unless session[:userid]
  	@current_user ||= User.find(session[:userid])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_path
  end
end
