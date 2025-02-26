class CourseCardComponent < ViewComponent::Base
  def initialize(course:, user:, show_description: true)
    @course = course
    @user = user
    @show_description = show_description
    @progression = course.progressions.find_by(user: user) if user
  end

  def completed?
    @progression&.completed_at.present?
  end

  def in_progress?
    @progression.present? && !completed?
  end

  def progress_percentage
    @progression&.progress_percentage || 0
  end
end
