class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :start, :confirm_start ]

  def show
    @progression = current_user&.progressions&.find_by(course: @course)
  end

  def confirm_start
    if current_user
      return start
    end
    @user = User.create
    session[:temporary_user_id] = @user.id
  end

  def start
    user = find_or_create_user
    ensure_user_session(user)

    @progression = @course.start(user)
    redirect_to course_step_path(@course, @progression.current_step)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def find_or_create_user
    if session[:temporary_user_id]
      temp_user = User.find_by(id: session[:temporary_user_id])
      session.delete(:temporary_user_id)
      temp_user
    else
      current_user || User.create
    end
  end

  def ensure_user_session(user)
    session[:user_id] = user.id unless current_user
  end
end
