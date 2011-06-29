class Catalog::CertificationsController < ApplicationController
  before_filter :authenticate_user!
 # load_and_authorize_resource
  before_filter :recent,:only=>[:index]
  def index
    @certifications = Certification.all
     @certification = Certification.new
  end

  def show
    @certification = Certification.find(params[:id])
  end

  def new
    @certification = Certification.new
  end

  def create
    @certification = Certification.new(params[:certification])
    if @certification.save
      redirect_to catalog_certifications_path, :notice => "Successfully created certification."
      #redirect_to [:catalog, @certification], :notice => "Successfully created certification."
    else
      render :action => 'new'
    end
  end

  def edit
    @certification = Certification.find(params[:id])
  end

  def update
    @certification = Certification.find(params[:id])
    if @certification.update_attributes(params[:certification])
      redirect_to [:catalog, @certification], :notice  => "Successfully updated certification."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @certification = Certification.find(params[:id])
    @certification.destroy
    redirect_to catalog_certifications_url, :notice => "Successfully destroyed certification."
  end
  
  def active
    super(Certification)
  end
   private

  def recent
    @recent = Certification.recent
  end
end
