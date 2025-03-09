class LearningObjective < ApplicationRecord
  belongs_to :standard_section
  has_many :learning_objective_steps, dependent: :destroy
  has_many :steps, through: :learning_objective_steps
  has_many :learning_objective_associated_sections, dependent: :destroy
  has_many :associated_sections, through: :learning_objective_associated_sections,
           source: :standard_section

  validates :description, presence: true
  validates :objective_id, presence: true, uniqueness: { scope: :standard_section_id }

  # Check if a user has completed this learning objective
  def completed_by?(user)
    # First check if all linked question steps are answered correctly
    steps_completed = steps.where(step_type: "question").all? do |step|
      step.questions.all? do |question|
        answer = UserAnswer.find_by(user: user, question: question)
        answer&.correct?
      end
    end

    return false unless steps_completed

    # Then check if all associated sections are completed (if any)
    if associated_sections.any?
      return false unless associated_sections.all? { |section| section.completed_by?(user) }
    end

    true
  end

  # Find learning objective by its ID within a standard
  def self.find_in_standard(objective_id, standard)
    joins(standard_section: :standard).where(
      objective_id: objective_id,
      standard_sections: { standard_id: standard.id }
    ).first
  end
end
