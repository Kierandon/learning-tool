class AnswersController < ApplicationController
  before_action :set_course_and_step
  before_action :set_progression
  before_action :set_question

  def create
    process_answer
    next_step = @progression.next_step
    if next_step
      redirect_to course_step_path(@course, @step, just_answered: true)
    else
      redirect_to course_complete_path(@course)
    end
  end

  private

  def set_course_and_step
    @course = Course.find(params[:course_id])
    @step = @course.steps.find(params[:step_id])
  end

  def set_progression
    @progression = current_user.progressions.find_by!(course: @course)
  end

  def set_question
    @question = @step.questions.first
  end

  def process_answer
    permitted_answer = params.require(:answer).permit!.to_h
    answer_service = AnswerService.new(@question, current_user)
    answer_service.process(permitted_answer)
  end

  def next_step
    @next_step ||= @step.next_step || @course.steps.last
  end
end
