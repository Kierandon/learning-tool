class AnswersController < ApplicationController
  before_action :set_course_and_step
  before_action :set_progression
  before_action :set_question

  def create
    process_answer
    @progression.update!(current_step: next_step)
    redirect_to course_step_path(@course, @step, just_answered: true)
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

  def handle_correct_answer
    if next_step
      advance_to_next_step
    else
      complete_course
    end
  end

  def handle_incorrect_answer
    redirect_to course_step_path(@course, @step), alert: "Incorrect!"
  end

  def advance_to_next_step
    @progression.update!(current_step: next_step)
    redirect_to course_step_path(@course, next_step), notice: "Correct!"
  end

  def complete_course
    redirect_to course_path(@course),
      notice: "Course completed! #{@question.questionable.success_message}"
  end

  def next_step
    @next_step ||= @step.next_step || @course.steps.last
  end
end
