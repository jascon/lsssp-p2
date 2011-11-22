class Catalog::TopicsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :recent, :only=>[:index]
  uses_tiny_mce :options => {
      :theme => 'advanced',
      :theme_advanced_resizing => true,
      :theme_advanced_resize_horizontal => false,
      :plugins => %w{ table fullscreen }
  }
  layout "application", :except => [:show, :edit]

  def index
    @topics = Topic.search(params[:search]).paginate(:page =>params[:page], :per_page=>20)
    @topic = Topic.new
    @subtopic = Subtopic.new(:topic_id=>params[:id])
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
      redirect_to catalog_topics_path, :notice => "Topic Successfully updated.."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to catalog_topics_url, :notice => "Successfully destroyed topic."
  end

  def active
    super(Topic)
  end

  def export
    require 'fastercsv'
    topics = Topic.search(params[:search]).order("name")
    outfile = "Topics-" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["Name", "Description", "Created At"]
      topics.each do |topic|
        csv << [topic.name, topic.description, topic.created_at.strftime('%m.%b.%y')]
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end

  private

  def recent
    @recent = Topic.recent
  end
end
