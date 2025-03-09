class AnswersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_course_and_step
  before_action :set_progression
  before_action :set_question

  def create
    process_answer
    @progression.next_step!
    redirect_to course_step_path(@course, @step, just_answered: true)
  end

  private

  def set_course_and_step
    @course = Course.find(params[:course_id])
    @step = @course.steps.find(params[:step_id])
  end

  def set_progression
    @progression = current_user.progressions.where(course: @course).order(id: :desc).first!
  end

  def set_question
    @question = @step.questions.first
  end

  def process_answer
    permitted_answer = params.require(:answer).permit!.to_h
    answer_service = AnswerService.new(@question, current_user, @progression)
    answer_service.process(permitted_answer)

    if @question.answered_correctly?(current_user)
      current_user.increment!(:points, 10)
      DailyQuestService.new(current_user).update_quest_progress("answer_questions")
    end

    achievement_service = AchievementService.new(current_user)
    achievement_service.register_activity
    achievement_service.check_achievements
  end

  def next_step
    @next_step ||= @step.next_step || @course.steps.last
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
