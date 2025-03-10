module Standards
  class StandardCardComponent < ViewComponent::Base
    attr_reader :standard, :user

    def initialize(standard:, user:)
      @standard = standard
      @user = user
    end

    def completion_percentage
      return 0 unless user

      standard.completion_percentage(user)
    end

    def courses_count
      @standard.courses.count
    end

    def has_completed_courses?
      return false unless @user
      @standard.courses.any? { |course| course.progressions.where(user: @user, completed_at: nil).exists? }
    end
  end
end
