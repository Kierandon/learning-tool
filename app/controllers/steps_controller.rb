class StepsController < ApplicationController
  def show
    @course = Course.find(params[:course_id])
    @step = @course.steps.find(params[:id])
    @progression = current_user.progressions.find_by!(course: @course)

    if turbo_frame_request?
      render partial: "step_content", locals: {
        step: @step,
        course: @course,
        just_answered: params[:just_answered] == "true"
      }
    end
  end
end
