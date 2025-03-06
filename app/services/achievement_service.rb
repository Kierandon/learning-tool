class AchievementService
  def initialize(user)
    @user = user
  end

  def check_achievements
    check_question_count_achievements
    check_streak_achievements
  end

  def register_activity
    today = Date.current

    if @user.last_answer_date.nil?
      # First activity
      @user.update(current_streak: 1, last_answer_date: today)
    elsif @user.last_answer_date == today
      # Already registered today
      return
    elsif @user.last_answer_date == today - 1.day
      # Consecutive day
      new_streak = @user.current_streak + 1
      @user.update(
        current_streak: new_streak,
        last_answer_date: today,
        highest_streak: [ new_streak, @user.highest_streak ].max
      )
    else
      # Streak broken
      @user.update(current_streak: 1, last_answer_date: today)
    end

    check_streak_achievements
  end

  private

  def check_question_count_achievements
    question_count = UserAnswer.where(user: @user, correct: true).count

    Achievement.where(achievement_type: "question_count").each do |achievement|
      next if @user.achievements.include?(achievement)
      next unless question_count >= achievement.threshold

      award_achievement(achievement)
    end
  end

  def check_streak_achievements
    Achievement.where(achievement_type: "streak").each do |achievement|
      next if @user.achievements.include?(achievement)
      next unless @user.current_streak >= achievement.threshold

      award_achievement(achievement)
    end
  end

  def award_achievement(achievement)
    @user.user_achievements.create!(
      achievement: achievement,
      awarded_at: Time.current
    )
  end
end
