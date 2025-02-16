class TrueFalseQuestion < ApplicationRecord
  has_one :question, as: :questionable

  ACCEPTED_ANSWERS = [ true, false ]
  validates :correct_answer, inclusion: { in: ACCEPTED_ANSWERS }

  def correct_answer?(answer)
    answer == correct_answer
  end
end
