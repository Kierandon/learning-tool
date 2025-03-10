module Questions
  class CoreQuestionIconComponent < ViewComponent::Base
    def initialize(float_right: true)
      @float_right = float_right
    end

    attr_reader :float_right
  end
end
