class ServiceProvider::AssessorsController < ApplicationController
  before_filter :authenticate_user!,:must_be_service_provider
  def index
    @users = current_user.assessors(params[:approved]).paginate(:page =>params[:page], :per_page=>20).order("created_at DESC")
    @user = User.new(:role_id=>params[:id])
  end

# only the students belongs to this service provider are assign to an assessor
  def show
    @assessor = User.find(params[:id])
    #@students = current_user.students - @assessor.students # assign this service provider students to an assessor ,they are not assigned to an Assessor already.
    students = current_user.students.joins(:owned_certifications)#(params[:approved])  Toget only this service provider students who has at least one owned_certification
    @students = students - @assessor.students # assign this service provider students to an assessor ,they are not assigned to an Assessor already

  end

  def update
    assessor = User.find(params[:id])
    for student_id in params[:student_ids]
      assessor.inverse_followings.create(:user_id=>student_id)
    end
    redirect_to service_provider_assessor_path(@assessor),:notice=>"Students Assigned Successfully.."
  end

  def destroy
    assessor = User.find(params[:id])
    if params[:commit] == "Remove"
      Following.delete(:user_id=>params[:student_ids],:follower_id=>assessor.id)
      flash[:notice]="Students Removed Successfully.."
    else
      for student_id in params[:student_ids]
        Following.find_by_user_id_and_follower_id(student_id,assessor.id).update_attribute('follower_id',params[:user][:assessor_id])
      end
      flash[:notice]="Students Transferred Successfully.."
    end
    redirect_to students_service_provider_assessor_path(@assessor)
  end

  def approve
    @user = User.find(params[:id])
    @user.update_attribute('approved',@user.approved? ? false : true)
    respond_to do |format|
      format.js
    end
  end

  def students
    @assessor = User.find(params[:id])
    @students = @assessor.students
    @assessors = current_user.assessors #Available Assessors
  end

  def export
    require 'fastercsv'
    users =  current_user.assessors(params[:approved])
    outfile = "Users-" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["Name","Email","Registration Date","Approved?"]
      users.each do |user|
        csv << [user.name,user.email,user.created_at,user.approved? ? 'yes' : 'no']
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
