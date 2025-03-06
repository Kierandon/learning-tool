class StreakCalendarComponent < ViewComponent::Base
  def initialize(user:, days: 14)
    @user = user
    @days = days
    @activity_dates = get_activity_dates
  end

  private

  def get_activity_dates
    end_date = Date.current
    start_date = end_date - @days.days

    UserAnswer.where(user: @user)
      .where("created_at >= ?", start_date.beginning_of_day)
      .pluck(:created_at)
      .map { |date| date.to_date }
      .uniq
  end
end
