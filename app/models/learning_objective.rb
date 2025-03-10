class LearningObjective < ApplicationRecord
  belongs_to :standard_section
  has_many :learning_objective_steps, dependent: :destroy
  has_many :steps, through: :learning_objective_steps
  has_many :learning_objective_associated_sections, dependent: :destroy
  has_many :associated_sections, through: :learning_objective_associated_sections,
           source: :standard_section

  validates :description, presence: true
  validates :objective_id, presence: true, uniqueness: { scope: :standard_section_id }

  def completed_by?(user)
    return false unless all_steps_completed_by?(user)
    return false unless all_associated_sections_completed_by?(user)

    true
  end

  def self.find_in_standard(objective_id, standard)
    joins(standard_section: :standard).where(
      objective_id: objective_id,
      standard_sections: { standard_id: standard.id }
    ).first
  end

  private

  def all_steps_completed_by?(user)
    steps.where(step_type: "question").all? do |step|
      step.questions.all? do |question|
        answer = UserAnswer.find_by(user: user, question: question)
        answer&.correct?
      end
    end
  end

  def all_associated_sections_completed_by?(user)
    associated_sections.all? { |section| section.completed_by?(user) }
  end
end
