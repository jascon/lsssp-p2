class Student::CertificationsController < ApplicationController
  def index
    @certifications_owned = current_user.owned
  end
end
