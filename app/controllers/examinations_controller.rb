#Author: Chaitanya
#----------------------------------------
class ExaminationsController < ApplicationController
  before_filter :recent,:only=>[:index]
  layout "application", :except => [:show, :edit]

  def index
    @examinations = Examination.all

    @examinations = Examination.search(params[:search]).paginate(:page =>params[:page], :per_page=>20)
    @examination = Examination.new
  end

  def show
    @examination = Examination.find(params[:id])
  end

  def new
    @examination = Examination.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examination }
    end
  end

  def edit
    @examination = Examination.find(params[:id])
  end

  def create
    @examination = Examination.new(params[:examination])

    respond_to do |format|
      if @examination.save
        format.html { redirect_to(examinations_url, :notice => 'Certification was successfully created.') }
        format.xml  { render :xml => @examination, :status => :created, :location => @examination }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examination.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @examination = Examination.find(params[:id])

    respond_to do |format|
      if @examination.update_attributes(params[:examination])
        format.html { redirect_to(examinations_url, :notice => 'Certification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examination.errors, :status => :unprocessable_entity }
      end
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
  private
  def recent
    @recent = Examination.recent
  end
end
