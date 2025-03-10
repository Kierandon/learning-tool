module Courses
  class CourseCardComponent < ViewComponent::Base
    attr_reader :course, :user, :show_description

    def initialize(course:, user:, show_description: true)
      @course = course
      @user = user
      @show_description = show_description
    end

    def progression
      return nil unless user

      @progression ||= user.progressions.find_by(course: course)
    end

    def progress_percentage
      return 0 unless progression

      progression.progress_percentage
    end

    def completed?
      progression&.completed_at.present?
    end

    def in_progress?
      progression.present? && !completed?
    end
  end
end
