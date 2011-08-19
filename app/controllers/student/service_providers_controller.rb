class Student::ServiceProvidersController < ApplicationController
  before_filter :authenticate_user!,:must_be_student
  def index
    #getting service providers who have at least one certification
    @service_providers = User.with_role(2).joins(:provided_certifications).group('users.name')
  end

  def show
    @service_provider = User.find(params[:id])
    @provided_certifications = @service_provider.provided_certifications
    # get an id of service provider and display info of that user
    #student_service_provider_path(id) or [:student, @service_provider]
  end

  def create
    certification = Certification.find(params[:cid])
    owned_certification = OwnedCertification.new(:provider_id=>params[:id],:certification_id =>certification.id,:amount=>certification.price)
    current_user.owned_certifications <<  owned_certification
    if current_user.save
      flash[:notice] = "Payment Success..! Online Exam Created "
      owned_certification.create_student_exam(:certification_id=>certification.id,:no_of_questions=>certification.no_of_questions)  #create student_exam for this user
    else
      flash[:error] = "Payment Failure."
    end
    # redirect_to student_service_provider_path(params[:id])
    redirect_to  student_certifications_path
  end

  def destroy
    following = Following.find_by_user_id_and_follower_id(current_user.id,params[:id])
    following.delete  ? flash[:notice] = "Removed Service Provider Successfully.." : flash[:error] = "Unable to remove this service provider."
    #TODO remove all student_certifications provided by this servicve provider to this user
    redirect_to my_service_providers_student_service_providers_path
  end

  def my_service_providers
    @my_service_providers = current_user.following_service_providers
  end

end
