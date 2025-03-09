class StandardCardComponent < ViewComponent::Base
  def initialize(standard:, user: nil)
    @standard = standard
    @user = user
  end

  def courses_count
    @standard.courses.count
  end

  def has_completed_courses?
    return false unless @user
    @standard.courses.any? { |course| course.progressions.where(user: @user, completed_at: nil).exists? }
  end
end
