class CertificationsController < ApplicationController
  before_filter :authenticate_user! ,:load_certifications

  def index
    @owned_certifications = OwnedCertification.all.paginate(:page =>params[:page],:per_page=>10 )
  end

  def purchased_certification
    if params[:certification_id] == '' or params[:certification_id].nil?
      redirect_to :action=>'index'
    else
      @owned_certifications = OwnedCertification.by_certification(params[:certification_id]).paginate(:page =>params[:page],:per_page=>10 )
    end
  end

  def exams
    @student_exams = StudentExam.by_status_and_certification(params[:status],params[:certification_id]).paginate(:page =>params[:page],:per_page=>10 )
  end

  private
  def load_certifications
    @certifications = Certification.active
  end
end
