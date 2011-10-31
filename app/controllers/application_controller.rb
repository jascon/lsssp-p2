class ApplicationController < ActionController::Base
  protect_from_forgery
  # layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }

  helper_method :has_role?, :date_time_stamp, :exam_result
  # Redirect to home page if user doesn't have permission
  #----------------------------------------------------
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  # helper_methods
  def date_time_stamp(datetime)
    datetime.strftime("%b-%d-%Y %H:%M:%S")
  end

  def exam_result(owned_certification)
    if owned_certification.student_exam.percentage == 0
      "<span class='exam_result_pending'>Pending</span>".html_safe
    elsif owned_certification.student_exam.percentage >= owned_certification.certification.pass_marks_percentage
      "<span class='pass'>Pass</span>".html_safe
    else
      "<span class='fail'>Fail</span>".html_safe
    end
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

  # Only Superadmin can access certain pages
  #------------------------------------------------------
  def must_be_super_admin
    unless current_user.role.name.eql?('Super Admin')
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
    current_user.role.name.gsub(/ /, '').underscore.to_sym.eql?(role) if current_user
  end


  #using this method as super in child controllers(DRY)
  #----------------------------------------------------
  def active(model)
    @model = model.find(params[:id])
    @model.toggle! :active # update_attribute('active',@model.active? ? false : true )
    respond_to { |format| format.js }
  end

  def after_sign_in_path_for(resource)
    if user_signed_in? & has_role?(:student)
      stored_location_for(resource) || student_certifications_url
    elsif user_signed_in? & has_role?(:super_admin)
      stored_location_for(resource) || super_admin_users_url
    elsif user_signed_in? & has_role?(:service_provider)
      stored_location_for(resource) || service_provider_certifications_url
    else
      stored_location_for(resource) || root_url
    end
  end

end
