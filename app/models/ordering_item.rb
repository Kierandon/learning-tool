class OrderingItem < ApplicationRecord
  belongs_to :ordering_question

  validates :content, presence: true
  validates :correct_position, presence: true, numericality: { only_integer: true }
end
