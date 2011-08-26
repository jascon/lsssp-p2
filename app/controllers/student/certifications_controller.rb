class Student::CertificationsController < ApplicationController
  def index
    @certifications_owned = current_user.owned_certifications
  end

  def assignments
   @owned_certification = OwnedCertification.includes([:certification,:student_assignments=>{:assignment=>:attachments}]).find(params[:id])
  end
=begin
  def download
     @attachment = Attachment.find(params[:id])
     send_file @attachment.attachment.path, :type => @attachment.attachment_content_type, :disposition => 'inline'
  end
=end

end
