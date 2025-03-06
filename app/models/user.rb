class User < ApplicationRecord
  has_many :progressions
  has_many :courses, through: :progressions
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements
  has_many :daily_quests, dependent: :destroy

  before_create :generate_login_hash

  validates :login_hash, uniqueness: true

  def level
    (points / 100.0).floor + 1
  end

  def points_to_next_level
    next_level = level + 1
    points_needed = next_level * 100
    points_needed - points
  end

  def level_progress_percentage
    current_level_points = (level - 1) * 100
    progress_in_level = points - current_level_points
    (progress_in_level / 100.0) * 100
  end

  private

  # Yes this may (will) break eventually but for the amount of users testing the app it's fine.
  def generate_login_hash
    loop do
      self.login_hash = SecureRandom.random_number(999999)
      break unless User.exists?(login_hash: login_hash)
    end
  end
end
