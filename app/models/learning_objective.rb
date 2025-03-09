class LearningObjective < ApplicationRecord
  belongs_to :standard_section
  has_many :learning_objective_steps, dependent: :destroy
  has_many :steps, through: :learning_objective_steps

  validates :description, presence: true
  validates :objective_id, presence: true, uniqueness: { scope: :standard_section_id }

  # Check if a user has completed this learning objective
  def completed_by?(user)
    # If no steps are linked, it cannot be completed
    return false if steps.none?

    # A learning objective is complete when all linked question steps are answered correctly
    steps.where(step_type: "question").all? do |step|
      step.questions.all? do |question|
        answer = UserAnswer.find_by(user: user, question: question)
        answer&.correct?
      end
    end
  end

  # Find learning objective by its ID within a standard
  def self.find_in_standard(objective_id, standard)
    joins(standard_section: :standard).where(
      objective_id: objective_id,
      standard_sections: { standard_id: standard.id }
    ).first
  end
end
