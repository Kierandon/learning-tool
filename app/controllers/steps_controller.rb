class StepsController < ApplicationController
  def show
    @course = Course.find(params[:course_id])
    @step = @course.steps.find(params[:id])
    @progression = current_user.progressions.find_by!(course: @course)

    if params[:update_progression] == "true" && @progression.current_step != @step
      @progression.update!(current_step: @step)
    end

    if turbo_frame_request?
      render partial: "step_content", locals: {
        step: @step,
        course: @course,
        just_answered: params[:just_answered] == "true"
      }
    end
  end
end
