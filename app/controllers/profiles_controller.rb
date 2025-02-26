class ProfilesController < ApplicationController
  def show
    if current_user
      @user = current_user
    else
      redirect_back_or_to root_path
    end
  end
end
