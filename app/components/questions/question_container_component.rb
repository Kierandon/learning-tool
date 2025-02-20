class Questions::QuestionContainerComponent < ViewComponent::Base
  def initialize(question:, form:, just_answered: false)
    @question = question
    @form = form
    @just_answered = just_answered
  end

  private

  def question_component
    "Questions::#{@question.questionable_type}Component".constantize.new(
      question: @question,
      form: @form,
      just_answered: @just_answered
    )
  end
end
