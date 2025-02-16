class Question < ApplicationRecord
  belongs_to :step
  belongs_to :questionable, polymorphic: true
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :questionable

  validates :prompt, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  delegate :correct_answer?, to: :questionable

  QUESTION_TYPES = {
    TrueFalseQuestion => "true_false"
  }.freeze

  def check_answer(submitted_answer)
    questionable.correct_answer?(submitted_answer)
  end
end
