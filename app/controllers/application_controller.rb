class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :has_role?
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

  # Only Student can access certain pages
  #------------------------------------------------------
  def must_be_student
    unless current_user.role.name.eql?('Student')
      flash[:error] = "Access denied."
      redirect_to root_url
    end
  end

  # Only Service Providers can access certain pages
  #------------------------------------------------------
  def must_be_service_provider
    unless current_user.role.name.eql?('Service Provider')
      flash[:error] = "Access denied."
      redirect_to root_url
    end
  end

  # Only Accessor can access certain pages
  #------------------------------------------------------
  def must_be_assessor
    unless current_user.role.name.eql?('Assessor')
      flash[:error] = "Access denied."
      redirect_to root_url
    end
  end

  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end
  # find user role and return true(making it as a helper method to use in views)
  #------------------------------------------------------------------
  def has_role?(role)
    current_user.role.name.gsub(/ /,'').underscore.to_sym.eql?(role) if current_user
  end


  #using this method as super in child controllers(DRY)
  #----------------------------------------------------
  def active(model)
    @model = model.find(params[:id])
    @model.update_attribute('active',@model.active? ? false : true )
    respond_to { |format| format.js }
  end
end
