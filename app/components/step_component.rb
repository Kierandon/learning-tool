class StepComponent < ViewComponent::Base
  def initialize(step:, course:, just_answered: false)
    @step = step
    @course = course
    @just_answered = just_answered
  end

  private

  def content_component
    component_class = {
      "info" => InfoStepComponent,
      "question" => QuestionStepComponent
    }[@step.step_type]

    if component_class == QuestionStepComponent
      component_class&.new(step: @step, course: @course, just_answered: @just_answered)
    else
      component_class&.new(step: @step, course: @course)
    end
  end
end
