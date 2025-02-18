class MatchingQuestion < ApplicationRecord
  has_one :question, as: :questionable
  has_many :matching_pairs, dependent: :destroy
  accepts_nested_attributes_for :matching_pairs

  validates :matching_style, inclusion: { in: %w[dropdown drawing] }

  def correct_answer?(submitted_pairs)
    return false unless submitted_pairs.is_a?(Hash)

    matching_pairs.all? do |pair|
      submitted_pairs["term_#{pair.id}"] == pair.id.to_s
    end
  end
end
