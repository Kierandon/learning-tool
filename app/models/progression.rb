class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :current_step, class_name: "Step", optional: true

  has_many :user_answers, dependent: :destroy

  before_create :set_initial_step

  def next_step!
    next_step = current_step.next_step
    update!(current_step: next_step)
    next_step
  end

  def complete!
    update(completed_at: Time.zone.now)
  end

  def progress_percentage
    return 100 if self.completed_at
    if current_step.nil?
      current_position = course.steps.count - 1
    else
      current_position = self.current_step.position - 1
    end
    ((current_position.to_f / self.course.steps.count) * 100).round
  end

  def completed_learning_objectives
    completed_step_ids = self.user_answers.select(&:correct).map(&:question).compact.map(&:step_id).uniq

    LearningObjective.joins(:learning_objective_steps)
                     .where(learning_objective_steps: { step_id: completed_step_ids })
                     .distinct
  end

  def steps_completed_count
    return course.steps.count if completed_at
    course.steps.where("position < ?", current_step&.position.to_i).count
  end

  def total_steps_count
    course.steps.count
  end

  def completed?
    completed_at.present?
  end

  def in_progress?
    current_step.present? && !completed?
  end

  def first_step
    course.steps.order(:position).first
  end

  private

  def current_step_position
    current_step&.position
  end

  def set_initial_step
    self.current_step = first_step
  end
end
