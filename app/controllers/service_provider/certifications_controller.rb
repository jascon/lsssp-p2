class ServiceProvider::CertificationsController < ApplicationController
  before_filter :authenticate_user!,:must_be_service_provider

  def index
    @certifications = Certification.active
  end

  def my_certifications
     @certifications = current_user.provided_certifications
  end

  def create
    current_user.certificate_providers << CertificateProvider.new(:certification_id => params[:id])
    current_user.save ? flash[:notice] = "Certification Registered Successfully.." : flash[:error] = "Unable to Register Certification."
    redirect_to my_certifications_service_provider_certifications_url
  end

  def destroy
    certificate_provider = current_user.certificate_providers.find(:first,:conditions=>{:certification_id=>params[:id]})
    certificate_provider.destroy
    flash[:notice] = "Removed Certification."
    redirect_to my_certifications_service_provider_certifications_url
  end

end

