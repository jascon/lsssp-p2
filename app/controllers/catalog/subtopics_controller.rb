class Catalog::SubtopicsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :recent,:only=>[:index]
  def index
    @subtopics = Subtopic.search(params[:search],params[:topic_id],params[:subtopic_status] ||='all' )
    @subtopic = Subtopic.new(:topic_id=>params[:id])
  end

  def show
    @subtopic = Subtopic.find(params[:id])
  end

  def new
    @subtopic = Subtopic.new
  end

  def create
    @subtopic = Subtopic.new(params[:subtopic])
    if @subtopic.save
      redirect_to [:catalog, @subtopic], :notice => "Successfully created subtopic."
    else
      render :action => 'new'
    end
  end

  def edit
    @subtopic = Subtopic.find(params[:id])
  end

  def update
    @subtopic = Subtopic.find(params[:id])
    if @subtopic.update_attributes(params[:subtopic])
      redirect_to [:catalog, @subtopic], :notice  => "Successfully updated subtopic."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @subtopic = Subtopic.find(params[:id])
    @subtopic.destroy
    redirect_to catalog_subtopics_url, :notice => "Successfully destroyed subtopic."
  end
  def active
    super(Subtopic)
  end
  private

  def recent
    @recent = Subtopic.recent
  end
end
