class DailyQuestService
  def initialize(user)
    @user = user
  end

  def generate_daily_quests
    return if @user.daily_quests.today.exists?

    @user.daily_quests.where("expires_at < ?", Time.current).update_all(completed: true)

    create_answer_questions_quest
  end

  def update_quest_progress(quest_type, count = 1)
    @user.daily_quests.active.where(quest_type: quest_type).each do |quest|
      quest.update(
        current_count: [ quest.current_count + count, quest.target_count ].min
      )

      if quest.current_count >= quest.target_count
        complete_quest(quest)
      end
    end
  end

  private

  def create_answer_questions_quest
    @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: rand(3..5),
      current_count: 0,
      reward_points: rand(15..25),
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )
  end

  def complete_quest(quest)
    quest.update(completed: true)
    @user.increment!(:points, quest.reward_points)
  end
end
