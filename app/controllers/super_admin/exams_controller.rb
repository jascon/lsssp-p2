class SuperAdmin::ExamsController < ApplicationController
  def index
    @student_exams = StudentExam.finished.paginate(:page =>params[:page],:per_page=>10 )
  end
end
