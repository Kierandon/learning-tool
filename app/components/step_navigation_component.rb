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
    if @step.next_step && @step.all_questions_answered?(@user)
      course_step_path(@course, @step.next_step)
    else
      nil
    end
  end

  def show_complete_button?
    @step.next_step.nil? && @step.all_questions_answered?(@user) && !@course.completed_by?(@user)
  end

  def reviewing_course?
    @course.progressions.where(user: @user).order(created_at: :desc).first&.completed_at.present?
  end
end
