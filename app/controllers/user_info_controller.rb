class UserInfoController < ApplicationController
  layout nil
  respond_to :js
  def index
    @user = User.find(params[:id])
  end

end
