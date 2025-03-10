module Steps
  class QuestionStepComponent < ViewComponent::Base
    def initialize(step:, course:, just_answered: false)
      @step = step
      @course = course
      @just_answered = just_answered
    end

    def render_core_question_icon?
      @step.learning_objectives.any?
    end

    def questions
      @step.questions
    end

    def all_questions_answered?(user)
      @step.all_questions_answered?(user)
    end

    def form_url
      course_step_answers_path(@course, @step)
    end
  end
end
