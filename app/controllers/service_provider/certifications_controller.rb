class ServiceProvider::CertificationsController < ApplicationController
   before_filter :authenticate_user!,:must_be_service_provider

  def index
    @certifications = Certification.active
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

