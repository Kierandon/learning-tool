class MatchingPair < ApplicationRecord
  belongs_to :matching_question

  validates :term, presence: true
  validates :definition, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
end
