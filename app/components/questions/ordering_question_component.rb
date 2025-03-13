class Questions::OrderingQuestionComponent < Questions::BaseQuestionComponent
  def initialize(question: nil, form: nil, just_answered: false, mock: false)
    super
    @items = @question.questionable.ordering_items
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

  def submitted_order
    return [] unless @just_answered
    latest_answer&.answer_data&.dig(:submitted_order) || []
  end

  def correct_order
    return [] unless @just_answered
    latest_answer&.answer_data&.dig(:correct_order) || []
  end

  def success_message
    @question.questionable.success_message || "Correct! You put everything in the right order!"
  end

  def failure_message
    @question.questionable.failure_message || "That's not quite right. Here's the correct order:"
  end
end
