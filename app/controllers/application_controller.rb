class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_person
    @current_person ||= current_user.person if current_user
  end
  helper_method :current_person


  def authorize
  	redirect_to login_url, alert: "Not authorized" if current_user.nil?  	
  end
end
