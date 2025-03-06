class SessionsController < ApplicationController
  after_action :ensure_daily_quests, only: :create

  def new
  end

  def create
    user = User.find_by(login_hash: params[:session][:login_hash])

    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = "Invalid login, please try again."
      redirect_to new_session_path
    end
  end


  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def ensure_daily_quests
    if current_user
      DailyQuestService.new(current_user).generate_daily_quests
    end
  end
end
