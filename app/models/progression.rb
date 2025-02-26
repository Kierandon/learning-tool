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

  private

  def set_initial_step
    self.current_step = course.steps.order(:position).first
  end
end
