class Question < ApplicationRecord
  # == Associations ==
  belongs_to :step
  belongs_to :questionable, polymorphic: true, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_one :course, through: :step

  accepts_nested_attributes_for :questionable

  validates :prompt, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  before_validation :set_position

  delegate :correct_answer?, to: :questionable

  def check_answer(submitted_answer)
    questionable.correct_answer?(submitted_answer)
  end

  def answered_correctly_by?(user, progression = nil)
    progression ||= find_latest_progression(user)

    user_answers.where(
      user: user,
      progression: progression
    ).exists?
  end

  def first_attempt?
    user_answers.count == 1
  end

  private

  def set_position
    self.position = step.questions.maximum(:position).to_i + 1
  end

  def find_latest_progression(user)
    course.progressions.where(user: user).order(created_at: :desc).first
  end
end
