class ServiceProvider::CertificationsController < ApplicationController
   before_filter :authenticate_user!,:must_be_service_provider

  def index
    @certifications = Certification.active
    ## Creating Many Service Providers for single user(accessor)
  service_providers = User.where(:role_id=>2).limit(10)
  accessor =  User.where(:role_id=>3).first
  service_providers.each { |service_provider| Following.create(:user_id=>accessor.id,:follower_id=>service_provider.id) }

  ## Creating Many accessors for single user(Service Provider)
  accessors = User.where(:role_id=>34).order('created_at DESC').limit(10)
  service_provider = User.where(:role_id=>2).first
  accessors.each { |accessors| Following.create(:user_id=>accessors.id,:follower_id=>service_provider.id) }
  end

  def my_certifications

  end

  def create
    certification_provider = current_user.certificate_providers.build(:certification_id => params[:id])
    if certification_provider.save!
      flash[:notice] = "Certification Registered.."
      redirect_to my_certifications_service_provider_certifications_url
    else
      flash[:error] = "Unable to Register Certification."
      redirect_to my_certifications_service_provider_certifications_url
    end
  end

  def destroy
    certificate_provider = current_user.certificate_providers.find(:first,:conditions=>{:certification_id=>params[:id]})
    certificate_provider.destroy
    flash[:notice] = "Removed Certification."
    redirect_to my_certifications_service_provider_certifications_url
  end

end

