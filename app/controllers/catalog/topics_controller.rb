class Catalog::TopicsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :recent,:only=>[:index]
  def index
    @topics = Topic.search(params[:search])
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      #redirect_to [:catalog, @topic], :notice => "Successfully created topic."
       redirect_to catalog_topics_path, :notice => "Successfully created topic."
    else
      render :action => 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to [:catalog, @topic], :notice  => "Successfully updated topic."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to catalog_topics_url, :notice => "Successfully destroyed topic."
  end
  
  def update_status
    topic = Topic.find(params[:id])
    topic.update_attribute('active',topic.active? ? false : true )      
    redirect_to catalog_topics_url, :notice => "Successfully Updated topic."
  end
   private

  def recent
    @recent = Topic.recent
  end
end
