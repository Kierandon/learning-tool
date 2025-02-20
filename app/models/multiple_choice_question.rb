class MultipleChoiceQuestion < ApplicationRecord
  has_one :question, as: :questionable
  has_many :options, class_name: "MultipleChoiceOption", dependent: :destroy

  validates :allow_multiple_answers, inclusion: { in: [ true, false ] }

  def correct_answer?(selected_ids)
    return false if selected_ids.blank?

    correct_options = options.where(correct: true)
    selected_options = options.where(id: selected_ids)

    # all selected answers must be correct and all correct answers must be selected
    selected_options.all?(&:correct?) && correct_options.count == selected_options.count
  end
end
