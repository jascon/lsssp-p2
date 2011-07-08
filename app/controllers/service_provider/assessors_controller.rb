class ServiceProvider::AssessorsController < ApplicationController
  before_filter :authenticate_user!,:must_be_service_provider
  def index
    @users = current_user.assessors(params[:approved])
  end
  def approve
    @user = User.find(params[:id])
    @user.update_attribute('approved',@user.approved? ? false : true)
    respond_to do |format|
      format.js
    end
  end
  def show
    @assessor = User.find(params[:id])
  end

  def update

  end

  def export
    require 'csv'
    users =  current_user.assessors(params[:approved])
    outfile = "Users-" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = CSV.generate do |csv|
      csv << ["Name","Email","Registration Date","Approved?"]
      users.each do |user|
        csv << [user.name,user.email,user.created_at,user.approved? ? 'yes' : 'no']
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end

end
