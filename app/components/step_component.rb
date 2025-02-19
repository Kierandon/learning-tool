class StepComponent < ViewComponent::Base
  def initialize(step:, course:)
    @step = step
    @course = course
  end

  private

  def content_component
    component_class = {
      "info" => InfoStepComponent,
      "question" => QuestionStepComponent
    }[@step.step_type]

    component_class&.new(step: @step, course: @course)
  end
end
