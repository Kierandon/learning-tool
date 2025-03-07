class DailyQuestsComponent < ViewComponent::Base
  def initialize
  end

  def quests
    current_user.daily_quests.active
  end

  def any_quests?
    quests.any?
  end

  def time_until_reset
    end_of_day = Time.zone.now.end_of_day
    seconds = (end_of_day - Time.zone.now).to_i
    hours = seconds / 3600
    minutes = (seconds / 60) % 60

    "#{hours}h #{minutes}m"
  end
end
