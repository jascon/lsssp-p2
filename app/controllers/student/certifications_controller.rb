class Student::CertificationsController < ApplicationController
  def index
    @certifications_owned = current_user.owned_certifications
  end

  def assignments
   @owned_certification = OwnedCertification.includes([:certification,:student_assignments=>{:assignment=>:attachments}]).find(params[:id])
  end

end
