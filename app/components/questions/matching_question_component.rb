class Questions::MatchingQuestionComponent < Questions::BaseQuestionComponent
  def initialize(question: nil, form: nil, just_answered: false, mock: false)
    super
    @pairs = @question.questionable.matching_pairs
  end

  private

  def mock_question
    OpenStruct.new(
      prompt: "Match the following terms with their definitions.",
      questionable: OpenStruct.new(
        matching_pairs: [
          OpenStruct.new(id: 1, term: "HTML", definition: "A markup language for creating web pages."),
          OpenStruct.new(id: 2, term: "CSS", definition: "A style sheet language used for describing the presentation of a document."),
          OpenStruct.new(id: 3, term: "JavaScript", definition: "A programming language commonly used in web development.")
        ]
      ),
      core_question: false
    )
  end

  def incorrect_pairs
    return [] unless @just_answered
    latest_answer&.answer_data[:incorrect_pairs]
  end

  def success_message
    @question.questionable.success_message || "Correct! All pairs matched correctly!"
  end

  def failure_message
    @question.questionable.failure_message || "Some pairs were not matched correctly:"
  end
end
