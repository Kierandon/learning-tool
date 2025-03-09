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

  def completion_percentage(user)
    return 0 if learning_objectives.none?
    completed = learning_objectives.count { |lo| lo.completed_by?(user) }
    (completed.to_f / learning_objectives.count) * 100
  end
end
