class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    #@accessible_roles = Role.accessible_by(current_ability,:read)
    @accessible_roles = User::ROLES
  end
 
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end
end
