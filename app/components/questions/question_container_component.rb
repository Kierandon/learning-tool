class Questions::QuestionContainerComponent < ViewComponent::Base
  def initialize(question:, form:)
    @question = question
    @form = form
  end

  private

  def question_component
    "Questions::#{@question.questionable_type}Component".constantize.new(
      question: @question,
      form: @form
    )
  end
end
