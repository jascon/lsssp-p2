class Student::CertificationsController < ApplicationController
  def index
    @certifications_owned = current_user.owned_certifications
  end

  def assignments
   @owned_certification = OwnedCertification.includes(:student_assignments).find(params[:id])
  end

end
