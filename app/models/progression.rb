class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :current_step, class_name: "Step", optional: true

  before_create :set_initial_step

  def next_step
    next_step = current_step.next_step
    if next_step.nil?
      self.completed_at = Time.zone.now
      save!
      nil
    else
      update!(current_step: next_step)
      next_step
    end
  end

  def complete!
    update(completed_at: Time.zone.now)
  end

  def progress_percentage
    return 100 if self.completed_at

    total_steps = self.course.steps.count
    current_step_position = self.current_step_position || 0

    return 0 if total_steps == 0
    ((current_step_position.to_f / total_steps) * 100).round
  end

  private

  def current_step_position
    current_step&.position
  end

  def set_initial_step
    self.current_step = course.steps.order(:position).first
  end
end
