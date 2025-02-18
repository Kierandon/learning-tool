class Questions::MatchingQuestionComponent < ViewComponent::Base
  def initialize(question:, form:)
    @question = question
    @form = form
    @pairs = @question.questionable.matching_pairs
  end
end
