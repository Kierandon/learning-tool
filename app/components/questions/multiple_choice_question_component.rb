class Questions::MultipleChoiceQuestionComponent < Questions::BaseQuestionComponent
  private

  def mock_question
    OpenStruct.new(
      prompt: "Which programming languages are commonly used for web development?",
      questionable: OpenStruct.new(correct_answer: true, options: [
        OpenStruct.new(id: 1, text: "Ruby", correct?: true, feedback: "Correct! Ruby is widely used with frameworks like Rails."),
        OpenStruct.new(id: 2, text: "JavaScript", correct?: true, feedback: "Correct! JavaScript is essential for frontend development."),
        OpenStruct.new(id: 3, text: "Python", correct?: true, feedback: "Correct! Python is popular with frameworks like Django."),
        OpenStruct.new(id: 4, text: "Assembly", correct?: false, feedback: "Incorrect! Assembly is rarely used in web development."),
        OpenStruct.new(id: 5, text: "COBOL", correct?: false, feedback: "Incorrect! COBOL is mainly used in legacy business systems.")
      ]),
      core_question: false,
    )
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
end
