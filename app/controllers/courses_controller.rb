class CoursesController < ApplicationController
  before_action :set_course, only: [ :show ]

  def show
  end

  def start
    @course = Course.find(params[:id])
    user = current_user || User.create
    session[:user_id] = user.id unless current_user
    progression = @course.start(user)
    redirect_to course_step_path(@course, progression.current_step)
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
