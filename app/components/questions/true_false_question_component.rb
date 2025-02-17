class Questions::TrueFalseQuestionComponent < ViewComponent::Base
  def initialize(question:, form:)
    @question = question
    @form = form
  end
end
