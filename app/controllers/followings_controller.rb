class FollowingsController < ApplicationController
  def create
    @following = current_user.followings.build(:follower_id => params[:follower_id])
    if @following.save!
      flash[:notice] = "Registered With Service Provider."
      redirect_to root_url
    else
      flash[:error] = "Unable to Register with Service Provider."
      redirect_to root_url
    end
  end

  def destroy
    @following = current_user.followings.find(params[:id])
    @following.destroy
    flash[:notice] = "Removed Service Provider."
    redirect_to edit_user_registration_url
  end
end
