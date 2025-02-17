class StepComponent < ViewComponent::Base
  def initialize(step:, course:)
    @step = step
    @course = course
  end

  private

  def content_component
    case @step.step_type
    when "info"
      InfoStepComponent.new(step: @step, course: @course)
    when "question"
      QuestionStepComponent.new(step: @step, course: @course)
    end
  end
end
