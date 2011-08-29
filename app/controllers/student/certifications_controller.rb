class Student::CertificationsController < ApplicationController
  def index
    @certifications_owned = current_user.owned_certifications
  end

  def assignments
    @owned_certification = OwnedCertification.includes([:certification,:student_assignments=>{:assignment=>:attachments}]).find(params[:id])
  end

  def download
    @attachment = Attachment.find(params[:id])
    send_file @attachment.attachment.path, :type => @attachment.attachment_content_type, :disposition => 'inline'
  end

  def update_assignment
    student_assignment = StudentAssignment.find(params[:id])
    student_assignment.update_attributes(params[:student_assignment])
  end
end
