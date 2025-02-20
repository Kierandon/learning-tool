class QuestionStepComponent < ViewComponent::Base
  def initialize(step:, course:, just_answered: false)
    @step = step
    @course = course
    @just_answered = just_answered
  end
end
