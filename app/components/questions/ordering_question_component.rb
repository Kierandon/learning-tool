class Questions::OrderingQuestionComponent < ViewComponent::Base
  def initialize(question:, form:, just_answered: false)
    @question = question
    @form = form
    @just_answered = just_answered
    @items = @question.questionable.ordering_items
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def latest_answer
    @latest_answer ||= @question.user_answers.where(user: current_user).last
  end

  def submitted_order
    return [] unless @just_answered
    latest_answer&.answer_data&.dig(:submitted_order) || []
  end

  def correct_order
    return [] unless @just_answered
    latest_answer&.answer_data&.dig(:correct_order) || []
  end

  def all_correct?
    return false unless @just_answered
    latest_answer&.correct
  end

  def question_answered?
    @question.user_answers.where(user: current_user).exists?
  end

  def success_message
    @question.questionable.success_message || "Correct! You put everything in the right order!"
  end

  def failure_message
    @question.questionable.failure_message || "That's not quite right. Here's the correct order:"
  end
end
