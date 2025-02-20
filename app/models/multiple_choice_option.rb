class MultipleChoiceOption < ApplicationRecord
  belongs_to :multiple_choice_question

  validates :text, presence: true
  validates :correct, inclusion: { in: [ true, false ] }
  validates :feedback, presence: true, if: :incorrect?

  def incorrect?
    !correct?
  end
end
