class Step < ApplicationRecord
  belongs_to :course
  has_many :questions, -> { order(position: :asc) }, dependent: :destroy
  has_many :progressions, foreign_key: :current_step_id, dependent: :nullify
  has_many :learning_objective_steps, dependent: :destroy
  has_many :learning_objectives, through: :learning_objective_steps
  has_rich_text :content

  before_create :set_position

  def previous_step
    course.steps.find_by(position: position - 1)
  end

  def next_step
    course.steps.find_by(position: position + 1)
  end

  def all_questions_answered?(user, progression = nil)
    progression ||= course.progressions.where(user: user).order(created_at: :desc).first
    return true unless questions.any?
    questions.all? { |question| question.answered_correctly?(user, progression) }
  end

  def fulfills_objectives(objective_ids)
    return unless course&.standard

    objective_ids.each do |objective_id|
      objective = LearningObjective.find_in_standard(objective_id, course.standard)
      if objective && !learning_objectives.include?(objective)
        learning_objectives << objective
      end
    end
  end

  private

  def set_position
    self.position = course.steps.maximum(:position).to_i + 1
  end
end
