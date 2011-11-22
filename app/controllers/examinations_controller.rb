#Author: Chaitanya
#----------------------------------------
class ExaminationsController < ApplicationController
  before_filter :recent,:only=>[:index]
  layout "application", :except => [:show, :edit]

  def index
#     @examinations = Examination.search(params[:search]).paginate(:page =>params[:page], :per_page=>20)
    @examinations =  params[:id].blank? ? Examination.search(params[:search]).paginate(:page =>params[:page], :per_page=>20) :
    Examination.search(params[:search]).where(:topic_id=>params[:id]).paginate(:page =>params[:page], :per_page=>20)

    @subtopics = Subtopic.where(:topic_id => params[:id]) if params[:id]
    @examination = Examination.new(:topic_id=>params[:id])
  end

  def show
    @examination = Examination.find(params[:id])
  end

  def new
    @examination = Examination.new(:topic_id=>params[:id])
  end

  def edit
    @examination = Examination.find(params[:id])
    @subtopics = Subtopic.where(:topic_id => @examinaiton.topic_id)

  end

  def create
    @examination = Examination.new(params[:examination])

      if @examination.save
        redirect_to examinations_path, :notice => "Successfully created Examination."
      else
        @subtopics = Subtopic.where(:topic_id => params[:certification][:topic_id]) if params[:certification][:topic_id]
        render :action => 'new'
      end

  end

  def update
    @examination = Examination.find(params[:id])

    @examination.subtopic_questions.clear
    if @examination.update_attributes(params[:examination])
      redirect_to examinations_path, :notice  => "Successfully updated certification."
    else
      render :action => 'edit'
    end
  end

    def active
    super(Examination)
  end
  def destroy
    @examination = Examination.find(params[:id])
    @examination.destroy

    respond_to do |format|
      format.html { redirect_to(examinations_url) }
      format.xml  { head :ok }
    end
  end
    def export
    require 'fastercsv'
    examinations = Examination.search(params[:search]).order("name")
    outfile = "Certifications-" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["Name","Price","Discount Price", "Description", "Created At"]
      examinations.each do |examination|
        csv << [examination.name, examination.price,examination.discount_price,examination.description, examination.created_at.strftime('%m.%b.%y')]
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"
    end

    def load_subtopics
    @subtopics = Subtopic.where(:topic_id => params[:id])
    respond_to do |format|
      format.js
    end
  end
  private
  def recent
    @recent = Examination.recent
  end
end
