class ApplicationController < ActionController::Base
  protect_from_forgery
  def authenticate_admin_user! #use predefined method name
    redirect_to '/' and return if current_user == nil 
    redirect_to '/' and return if !current_user.admin? 
    authenticate_user! 
  end 
end
