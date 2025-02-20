class Step < ApplicationRecord
  belongs_to :course
  has_many :questions, -> { order(position: :asc) }, dependent: :destroy
  has_rich_text :content

  before_create :set_position

  def previous_step
    course.steps.find_by(position: position - 1)
  end

  def next_step
    course.steps.find_by(position: position + 1)
  end

  def all_questions_answered?(user)
    questions.all? { |question| question.answered_correctly?(user) }
  end

  private

  def set_position
    self.position = course.steps.maximum(:position).to_i + 1
  end
end
