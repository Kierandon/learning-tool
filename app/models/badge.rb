class Badge < ApplicationRecord
  belongs_to :course
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_one_attached :image
  has_rich_text :description

  validates :name, presence: true
end
