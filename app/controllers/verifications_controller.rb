class VerificationsController < ApplicationController
  def index

  end
  def search
    @user = User.where(:enrollment_no => params[:enroll])

   # @certifications = OwnedCertification.where(:owned_id => @user.id)
  end
end
