class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :current_step, class_name: "Step", optional: true

  before_create :set_initial_step

  private

  def set_initial_step
    self.current_step = course.steps.order(:position).first
  end
end
