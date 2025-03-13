class Questions::TrueFalseQuestionComponent < Questions::BaseQuestionComponent
  private

  def mock_question
    OpenStruct.new(
      prompt: "Standards help ensure consistency and quality across products and services.",
      questionable: OpenStruct.new(correct_answer: true),
      core_question: @core
    )
  end

  def correct_answer
    @question.questionable.correct_answer
  end
end
