class ApplicationController < ActionController::Base
  protect_from_forgery
  # Redirect to home page if user doesn't have permission
  #----------------------------------------------------
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
 #using this method as super in child controllers(DRY) 
 #----------------------------------------------------
  def active(model)
    puts "#################    #{params[:id]}"
    @model = model.find(params[:id])
    @model.update_attribute('active',@model.active? ? false : true )  
    respond_to { |format| format.js }
  end
end
