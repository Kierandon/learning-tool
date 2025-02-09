class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(login_hash: params[:session][:login_hash])

    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
