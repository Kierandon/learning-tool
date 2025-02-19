class StepNavigationComponent < ViewComponent::Base
  def initialize(step:, course:, user:)
    @step = step
    @course = course
    @user = user
  end

  private

  def previous_step_path
    course_step_path(@course, @step.previous_step) if @step.previous_step
  end

  def next_step_path
    course_step_path(@course, @step.next_step) if @step.next_step && @step.all_questions_answered?(@user)
  end
end
