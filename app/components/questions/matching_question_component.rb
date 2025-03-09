class Questions::MatchingQuestionComponent < ViewComponent::Base
  def initialize(question:, form:, just_answered: false)
    @question = question
    @form = form
    @just_answered = just_answered
    @pairs = @question.questionable.matching_pairs
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def all_correct?
    return false unless @just_answered
    latest_answer&.correct
  end

  def incorrect_pairs
    return [] unless @just_answered
    latest_answer&.answer_data[:incorrect_pairs]
  end

  def question_answered?
    @question.user_answers.where(
      user: current_user,
      progression: @question.course.progressions.where(user: current_user).order(created_at: :desc).first
    ).exists?
  end

  def latest_answer
    @latest_answer ||= @question.user_answers.where(user: current_user).last
  end

  def success_message
    @question.questionable.success_message || "Correct! All pairs matched correctly!"
  end

  def failure_message
    @question.questionable.failure_message || "Some pairs were not matched correctly:"
  end
end
