require "ostruct"

class Questions::OrderingQuestionComponent < ViewComponent::Base
  def initialize(question: nil, form: nil, just_answered: false, mock: false)
    @mock = mock
    @question = mock ? mock_question : question
    @form = form
    @just_answered = just_answered
    @items = @question.questionable.ordering_items
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def mock_question
    OpenStruct.new(
      prompt: "Arrange the following items in the correct order.",
      questionable: OpenStruct.new(
        ordering_items: [
          OpenStruct.new(id: 1, content: "Step 1"),
          OpenStruct.new(id: 2, content: "Step 2"),
          OpenStruct.new(id: 3, content: "Step 3")
        ]
      ),
      core_question: false
    )
  end

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
    return false if @mock
    @question.user_answers.where(
      user: current_user,
      progression: @question.course.progressions.where(user: current_user).order(created_at: :desc).first
    ).exists?
  end

  def success_message
    @question.questionable.success_message || "Correct! You put everything in the right order!"
  end

  def failure_message
    @question.questionable.failure_message || "That's not quite right. Here's the correct order:"
  end
end
