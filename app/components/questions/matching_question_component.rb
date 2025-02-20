class Questions::MatchingQuestionComponent < ViewComponent::Base
  def initialize(question:, form:, just_answered: false)
    @question = question
    @form = form
    @pairs = @question.questionable.matching_pairs
    @just_answered = just_answered
  end
end
