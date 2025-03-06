class Achievement < ApplicationRecord
  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements

  validates :name, presence: true
  validates :description, presence: true
  validates :achievement_type, presence: true
  validates :threshold, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  has_one_attached :icon
end
