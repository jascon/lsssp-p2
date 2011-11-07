class Assessor::StudentsController < ApplicationController
  before_filter :authenticate_user!#,:must_be_assessor
  before_filter :load_certifications,:only=>[:pending_assignments,:manage_assignments]
  def index
    @users = current_user.students.joins(:owned_certifications)#(params[:approved])  Toget only assessor students who has at least one owned_certification
  end

  def pending_assignments
    @owned_certifications = OwnedCertification.pending_assignments(current_user,params[:certification_id]).paginate(:page =>params[:page],:per_page=>10 )
    @assignments =  Assignment.where(:certification_id=>params[:certification_id]) unless params[:certification_id].blank?
  end

  def manage_assignments
    @owned_certifications = OwnedCertification.manage_assignments(current_user,params[:certification_id]).paginate(:page =>params[:page],:per_page=>10 )
  end

  def assign_assignments
    @student_assignments = []
    StudentAssignment.transaction do
      for a in  params[:assignment_ids]
        for oid in params[:owned_certification_ids]
          @student_assignments << StudentAssignment.new(:owned_certification_id=>oid,:assignment_id=>a,:assigner_id=>current_user.id)
        end
      end
      if @student_assignments.all?(&:valid?)
        @student_assignments.each(&:save!)
        flash[:notice] = "Assigned Successfully"
        redirect_to :action=>'pending_assignments'
      else
        flash[:error] = "Error while assigning."
        render 'pending_assignments'
      end
    end
  end

  def assignments
    @owned_certification = OwnedCertification.includes([:certification,{:student_assignments=>{:assignment=>:attachments}}]).find(params[:id])
  end

  def download
    @attachment = CompletedAttachment.find(params[:id])
    send_file @attachment.hanger.path, :type => @attachment.hanger_content_type, :disposition => 'inline'
  end

  def update_assignment_result
    @owned_certification = OwnedCertification.find(params[:id])
    @owned_certification.update_attribute('student_assignments_result',params[:owned_certification][:student_assignments_result])
    flash[:notice] = "Assignment Result Updated.."
    redirect_to :action=>:manage_assignments
  end

  private
  def load_certifications
    @certifications = Certification.active
  end

end
