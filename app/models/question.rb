class Question < ApplicationRecord
  belongs_to :step
  belongs_to :questionable, polymorphic: true, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :questionable

  validates :prompt, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  delegate :correct_answer?, to: :questionable

  def check_answer(submitted_answer)
    questionable.correct_answer?(submitted_answer)
  end

  def answered_correctly?(user)
    user_answers.where(user: user).exists?
  end
end
