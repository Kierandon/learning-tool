class Course < ApplicationRecord
  belongs_to :standard, optional: true

  validates :title, presence: true
  validates :description, presence: true
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }, allow_blank: true

  has_one :badge, dependent: :destroy

  has_many :steps, -> { order(position: :asc) }, dependent: :destroy
  has_many :progressions, dependent: :destroy
  has_many :users, through: :progressions

  def start(user)
    progress = progressions.create!(user: user, course: self, current_step: first_step)
    progress
  end

  private

  def first_step
    steps.order(:position).first
  end
end
