class Questions::MultipleChoiceQuestionComponent < ViewComponent::Base
  def initialize(question:, form:, just_answered: false)
    @question = question
    @form = form
    @just_answered = just_answered
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def latest_answer
    @latest_answer ||= @question.user_answers.where(user: current_user).last
  end

  def selected_options
    return [] unless @just_answered
    latest_answer&.answer_data&.dig("selected_options") || []
  end

  def feedback_for_option(option)
    return unless @just_answered
    selected = selected_options.any? { |so| so["id"] == option.id }
    if selected && !option.correct?
      option.feedback
    end
  end

  def question_answered?
    @question.user_answers.where(user: current_user).exists?
  end
end
