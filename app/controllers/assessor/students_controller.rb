class Assessor::StudentsController < ApplicationController
  def index
    # to get only students who buy the certification also use where if you want certification status
     @users = current_user.students.joins(:owned_certifications)#(params[:approved])
  end
end
