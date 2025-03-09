class Standard < ApplicationRecord
  has_many :sections, class_name: "StandardSection", dependent: :destroy
  has_many :courses

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  has_rich_text :description

  def top_level_sections
    sections.where(parent_section_id: nil)
  end
end
