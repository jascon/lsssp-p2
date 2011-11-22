class Catalog::SubtopicsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :recent, :only=>[:index]
  layout "application", :except => [:show, :edit]

  def index
    @subtopics = Subtopic.search(params[:search], params[:topic_id], params[:subtopic_status] ||='all').paginate(:page =>params[:page], :per_page=>20)
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
      redirect_to catalog_topics_path, :notice => "Successfully created subtopic."
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
      redirect_to catalog_topics_path, :notice => "Successfully updated subtopic."
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

    def export
    require 'fastercsv'
    topics = Subtopic.order("name")
    outfile = "Sub Topics-" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["Name", "Topic","Description", "Created At"]
      topics.each do |topic|
        csv << [topic.name, topic.topic.name,topic.description, topic.created_at.strftime('%m.%b.%y')]
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end

  private

  def recent
    @recent = Subtopic.recent
  end
end
