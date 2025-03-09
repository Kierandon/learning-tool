class StandardSection < ApplicationRecord
  belongs_to :standard
  belongs_to :parent_section, class_name: "StandardSection", optional: true
  has_many :subsections, class_name: "StandardSection", foreign_key: "parent_section_id", dependent: :destroy
  has_many :learning_objectives, dependent: :destroy

  validates :name, presence: true
  validates :section_id, presence: true, uniqueness: { scope: :standard_id }

  has_rich_text :description

  def top_level?
    parent_section_id.nil?
  end

  def all_subsections
    result = subsections.to_a
    subsections.each do |subsection|
      result += subsection.all_subsections
    end
    result
  end

  def completed_by?(user)
    return false if learning_objectives.none?
    learning_objectives.all? { |lo| lo.completed_by?(user) }
  end

  def completion_percentage_for(user)
    if learning_objectives.any?
      completed = learning_objectives.count { |lo| lo.completed_by?(user) }
      return (completed.to_f / learning_objectives.count) * 100
    end

    # For parent sections, calculate based on child sections
    child_sections = subsections.select { |section| section.has_learning_objectives? }
    return 0 if child_sections.empty?

    sum_of_percentages = child_sections.sum do |section|
      section.completion_percentage_for(user)
    end

    sum_of_percentages / child_sections.size
  end

  def has_learning_objectives?
    return true if learning_objectives.any?
    subsections.any? { |subsection| subsection.has_learning_objectives? }
  end
end
