class ServiceProvider::UsersController < ApplicationController
   before_filter :authenticate_user!,:must_be_service_provider
  def index
    @users = params[:type].eql?('accessor') ? current_user.accessors : current_user.students
  end

end
