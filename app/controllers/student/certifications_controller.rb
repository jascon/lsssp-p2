class Student::CertificationsController < ApplicationController
  def index
    @student_certifications = current_user.student_certifications
  end
end
