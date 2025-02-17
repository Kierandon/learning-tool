class Step < ApplicationRecord
  belongs_to :course
  has_many :questions, -> { order(position: :asc) }, dependent: :destroy
  has_rich_text :content

  def previous_step
    course.steps.find_by(position: position - 1)
  end

  def next_step
    course.steps.find_by(position: position + 1)
  end
end
