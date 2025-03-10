module Steps
  class InfoStepComponent < ViewComponent::Base
    def initialize(step:, course:)
      @step = step
      @course = course
    end
  end
end
