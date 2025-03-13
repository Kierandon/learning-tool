require "ostruct"

class Questions::BaseQuestionComponent < ViewComponent::Base
  def initialize(question: nil, form: nil, just_answered: false, mock: false)
    @mock = mock
    @question = mock ? mock_question : question
    @form = form
    @just_answered = just_answered
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def mock_question
    raise NotImplementedError, "Subclasses must implement mock_question"
  end

  def latest_answer
    @latest_answer ||= @question.user_answers.where(user: current_user).last
  end

  def question_answered?
    return false if @mock
    @question.user_answers.where(
      user: current_user,
      progression: @question.course.progressions.where(user: current_user).order(created_at: :desc).first
    ).exists?
  end

  def success_message
    @question.questionable.success_message || "Correct!"
  end

  def failure_message
    @question.questionable.failure_message || "That's not quite right."
  end

  def all_correct?
    return false unless @just_answered
    latest_answer&.correct
  end
end
