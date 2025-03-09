class Question < ApplicationRecord
  belongs_to :step
  belongs_to :questionable, polymorphic: true, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :questionable

  validates :prompt, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  before_validation :set_position

  delegate :correct_answer?, to: :questionable

  def check_answer(submitted_answer)
    questionable.correct_answer?(submitted_answer)
  end

  def answered_correctly?(user)
    user_answers.where(user: user).exists?
  end

  def is_first_attempt?
    user_answers.count == 1
  end

  def set_position
    self.position = step.questions.maximum(:position).to_i + 1
  end
end
