class StandardSection < ApplicationRecord
  belongs_to :standard
  belongs_to :parent_section, class_name: "StandardSection", optional: true
  has_many :subsections, class_name: "StandardSection", foreign_key: "parent_section_id", dependent: :destroy
  has_many :learning_objectives, dependent: :destroy
  has_many :learning_objective_associated_sections, dependent: :destroy
  has_many :associated_sections, through: :learning_objective_associated_sections,
           source: :standard_section

  validates :name, presence: true
  validates :section_id, presence: true, uniqueness: { scope: :standard_id }

  has_rich_text :description

  def top_level?
    parent_section_id.nil?
  end

  def all_subsections
    subsections.flat_map { |subsection| [ subsection ] + subsection.all_subsections }
  end

  def completed_by?(user)
    all_learning_objectives_completed?(user) && all_relevant_subsections_completed?(user)
  end

  def completion_percentage_for(user)
    if learning_objectives.any?
      completed = learning_objectives.count { |lo| lo.completed_by?(user) }
      return (completed.to_f / learning_objectives.count) * 100
    end

    calculate_completion_percentage_from_subsections(user)
  end

  def has_learning_objectives?
    learning_objectives.any? || subsections.any?(&:has_learning_objectives?)
  end

  private

  def all_learning_objectives_completed?(user)
    learning_objectives.all? { |lo| lo.completed_by?(user) }
  end

  def all_relevant_subsections_completed?(user)
    relevant_subsections = subsections.select(&:has_learning_objectives?)
    relevant_subsections.all? { |section| section.completed_by?(user) }
  end

  def calculate_completion_percentage_from_subsections(user)
    child_sections = subsections.select(&:has_learning_objectives?)
    return 0 if child_sections.empty?

    sum_of_percentages = child_sections.sum { |section| section.completion_percentage_for(user) }
    sum_of_percentages / child_sections.size
  end
end
