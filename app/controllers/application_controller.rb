class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :set_locale
  protect_from_forgery with: :null_session

  def current_user
  	return unless session[:userid]
  	@current_user ||= User.find(session[:userid])
  end

  rescue_from CanCan::AccessDenied do |exception|
    unless current_user
      redirect_to login_url
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  protected
    def set_locale
      I18n.locale = :ru
    end
end
