require "test_helper"

class DailyQuestServiceTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @service = DailyQuestService.new(@user)
  end

  test "should not generate daily quests if they already exist for today" do
    @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: 5,
      current_count: 0,
      reward_points: 20,
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )

    assert_no_difference "DailyQuest.count" do
      @service.generate_daily_quests
    end
  end

  test "should generate daily quests if none exist for today" do
    assert_difference "DailyQuest.count" do
      @service.generate_daily_quests
    end

    quest = @user.daily_quests.last
    assert_equal "answer_questions", quest.quest_type
    assert_includes 3..5, quest.target_count
    assert_equal 0, quest.current_count
    assert_includes 15..25, quest.reward_points
    assert_equal false, quest.completed
    assert_equal Time.zone.now.end_of_day.to_i, quest.expires_at.to_i
  end

  test "should update quest progress" do
    quest = @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: 5,
      current_count: 0,
      reward_points: 20,
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )

    @service.update_quest_progress("answer_questions", 3)
    quest.reload
    assert_equal 3, quest.current_count
  end

  test "should not exceed target count when updating progress" do
    quest = @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: 5,
      current_count: 0,
      reward_points: 20,
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )

    @service.update_quest_progress("answer_questions", 10)
    quest.reload
    assert_equal 5, quest.current_count
  end

  test "should complete quest and award points when target is reached" do
    quest = @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: 5,
      current_count: 0,
      reward_points: 20,
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )

    assert_difference "@user.reload.points", 20 do
      @service.update_quest_progress("answer_questions", 5)
    end

    quest.reload
    assert_equal true, quest.completed
  end

  test "should handle multiple active quests of the same type" do
    quest1 = @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: 5,
      current_count: 0,
      reward_points: 20,
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )

    quest2 = @user.daily_quests.create!(
      quest_type: "answer_questions",
      target_count: 3,
      current_count: 0,
      reward_points: 15,
      completed: false,
      expires_at: Time.zone.now.end_of_day
    )

    @service.update_quest_progress("answer_questions", 3)

    quest1.reload
    quest2.reload
    assert_equal 3, quest1.current_count
    assert_equal 3, quest2.current_count
    assert_equal true, quest2.completed
    assert_equal false, quest1.completed
  end
end
