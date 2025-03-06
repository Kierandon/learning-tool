class DailyQuest < ApplicationRecord
  belongs_to :user

  scope :active, -> { where("expires_at > ?", Time.current) }
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  TYPES = {
    "answer_questions" => "Answer questions correctly"
  }

  def description
    case quest_type
    when "answer_questions"
      "Answer #{target_count} questions correctly"
    else
      "Unknown quest"
    end
  end

  def progress_percentage
    return 100 if completed
    ((current_count.to_f / target_count) * 100).round
  end
end
