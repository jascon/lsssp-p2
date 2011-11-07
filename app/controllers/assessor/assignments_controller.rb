class Assessor::AssignmentsController < ApplicationController
   before_filter :authenticate_user! #,:must_be_super_admin #:must_be_assessor
   before_filter :load_certifications,:only=>[:new,:create,:edit,:update]
   before_filter :recent, :only=>[:index]

   uses_tiny_mce :options => {
                            :theme => 'advanced',
                            :theme_advanced_resizing => true,
                            :theme_advanced_resize_horizontal => false,
                            :plugins => %w{ table fullscreen }
                          }
     layout "application", :except => [:show,:edit]
  def index
    @assignments = Assignment.search(params[:search]) ##current_user.assignments.search(params[:search])
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def new
    params[:no_of_attachments] ||= 2
     @assignment = Assignment.new
    params[:no_of_attachments].to_i.times { @assignment.attachments.build }

  end

  def create
    @assignment = Assignment.new(params[:assignment])
    @assignment.user_id = current_user.id
    if @assignment.save
      redirect_to assessor_assignments_url, :notice => "Assignment Successfully Created."
    else
      render :action => 'new'
    end
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      redirect_to assessor_assignments_url, :notice  => "Assignment Updated Successfully."
    else
      render :action => 'edit'
    end
  end
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to assessor_assignments_url, :notice => "Assignment Successfully Deleted."
  end

private

  def load_certifications
    @certifications = Certification.active
  end

    def recent
    @recent = Assignment.recent #current_user.assignments.recent
  end
end
