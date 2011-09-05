class Student::CertificationsController < ApplicationController
  uses_tiny_mce :only=>[:assignments], :options => {
      :theme => 'advanced',
      :theme_advanced_resizing => true,
      :theme_advanced_resize_horizontal => false,
      :plugins => %w{ table fullscreen }
  }
  def index
    @certifications_owned = current_user.owned_certifications
  end

  def assignments
    @owned_certification = OwnedCertification.includes([:certification,{:student_assignments=>{:assignment=>:attachments}}]).find(params[:id])
  end

  def download
    @attachment = Attachment.find(params[:id])
    send_file @attachment.attachment.path, :type => @attachment.attachment_content_type, :disposition => 'inline'
  end

  def update_assignment
    student_assignment = StudentAssignment.find(params[:id])
    student_assignment.update_attributes(params[:student_assignment])
    owned_certification = student_assignment.owned_certification
    if params[:student_assignment][:status].eql?('completed')
      # update owned_certification.student_assignments_status to true if all of the student_assignments are completed
      owned_certification.update_attribute('student_assignments_status',true) unless owned_certification.student_assignments.map(&:status).include?('pending')
    end
    redirect_to :action=>'assignments',:id=>owned_certification
  end
end
