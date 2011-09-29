class Catalog::CertificationsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource
  before_filter :recent,:only=>[:index]
  layout "application", :except => [:show, :edit]

  def index
    @certifications =  params[:id].blank? ? Certification.search(params[:search]) :
        Certification.search(params[:search]).where(:topic_id=>params[:id])
    @subtopics = Subtopic.where(:topic_id => params[:id]) if params[:id]
    @certification = Certification.new(:topic_id=>params[:id])
  end



  def show
    @certification = Certification.find(params[:id])
  end

  def new
    @certification = Certification.new(:topic_id=>params[:id])

  end

  def load_subtopics

    @subtopics = Subtopic.where(:topic_id => params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @certification = Certification.new(params[:certification])

    if @certification.save
      redirect_to catalog_certifications_path, :notice => "Successfully created certification."
      #redirect_to [:catalog, @certification], :notice => "Successfully created certification."
    else
      @subtopics = Subtopic.where(:topic_id => params[:certification][:topic_id]) if params[:certification][:topic_id]
      render :action => 'new'
    end
  end

  def edit
    @certification = Certification.find(params[:id])
    @subtopics = Subtopic.where(:topic_id => @certification.topic_id)
  end

  def update
    @certification = Certification.find(params[:id])
    @certification.subtopic_questions.clear
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
