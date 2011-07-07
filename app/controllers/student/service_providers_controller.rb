class Student::ServiceProvidersController < ApplicationController
  before_filter :authenticate_user!,:must_be_student
  def index
    @service_providers = User.with_role(2)
  end
  def show
    # get an id of service provider and display info of that user
    #student_service_provider_path(id) or [:student, @service_provider]
  end

  def my_service_providers

  end

end
