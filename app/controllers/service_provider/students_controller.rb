class ServiceProvider::StudentsController < ApplicationController
  before_filter :authenticate_user! ,:must_be_service_provider
  def index
    @users = current_user.students(params[:approved]).paginate(:page =>params[:page], :per_page=>20).order("created_at DESC")
    @user = User.new(:role_id=>params[:id])
  end
  def approve
    @user = User.find(params[:id])
    @user.toggle! :approved #update_attribute('approved',@user.approved? ? false : true)
    respond_to do |format|
      format.js
    end
  end
  def export
    require 'fastercsv'
    users =  current_user.students(params[:approved])
    outfile = "Users-" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["First Name", "Last Name", "Enrollment #", "Email", "Primary Contact", "Status", "Created At"]
      users.each do |u|
        csv << [u.name, u.last_name, u.enrollment_no, u.email, u.primary_number, u.approved? ? 'Yes' : 'No', u.created_at.strftime('%m.%b.%y')]
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end
  def new
       respond_to do |format|
      format.json { render :json => @user }
      format.xml { render :xml => @user }
      format.html
    end
  end
end
