class Standard < ApplicationRecord
  has_many :sections, class_name: "StandardSection", dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :learning_objectives, through: :sections

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  has_rich_text :description

  def top_level_sections
    sections.where(parent_section_id: nil)
  end

  def completed_by?(user)
    return false if learning_objectives.none? && subsections.none?

    direct_objectives_completed = learning_objectives.empty? ||
                                 learning_objectives.all? { |lo| lo.completed_by?(user) }

    subsections_completed = subsections.empty? ||
                           subsections.all? { |ss| ss.completed_by?(user) }

    direct_objectives_completed && subsections_completed
  end

  def completion_percentage(user)
    return 0 if learning_objectives.none?

    completed = learning_objectives.count { |lo| lo.completed_by?(user) }
    (completed.to_f / learning_objectives.count) * 100
  end

  def total_learning_objectives_count
    learning_objectives.count + subsections.sum(&:total_learning_objectives_count)
  end
end
