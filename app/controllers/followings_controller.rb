class FollowingsController < ApplicationController
   before_filter :authenticate_user!
  def create
    @following = current_user.followings.build(:follower_id => params[:follower_id])
    if @following.save
      flash[:notice] = "Successfully Registered With Service Provider."
      redirect_to student_service_provider_path(@following.follower.id)
    else
      flash[:error] = "Unable to Register with Service Provider."
      redirect_to student_service_providers_path
    end
  end

  def destroy
    @following = current_user.followings.find(params[:id])
    @following.destroy
    flash[:notice] = "Removed Service Provider."
    redirect_to edit_user_registration_url
  end
end
