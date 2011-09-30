class Certification::ExamsController < ApplicationController
   before_filter :authenticate_user!
  def index
    @student_exams = StudentExam.finished.paginate(:page =>params[:page],:per_page=>10 )
  end
  def purchased
    if params[:certification_id]
       @student_certifications = OwnedCertification.by_certification(params[:certification_id]).paginate(:page =>params[:page],:per_page=>10 )
    else
      @student_certifications = OwnedCertification.includes([:user,:provider,:certification]).order('created_at DESC').paginate(:page =>params[:page],:per_page=>10 )
    end
  end
end
