class StepsController < ApplicationController
  def show
    @course = Course.find(params[:course_id])
    @step = @course.steps.find(params[:id])
    @progression = current_user.progressions.find_by!(course: @course)
  end
end
