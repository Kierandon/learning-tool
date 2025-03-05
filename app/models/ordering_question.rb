class OrderingQuestion < ApplicationRecord
  has_one :question, as: :questionable
  has_many :ordering_items, -> { order(correct_position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :ordering_items

  def correct_answer?(submitted_order)
    return false if submitted_order.blank?

    submitted_ids = Array(submitted_order).map(&:to_s)
    correct_ids = ordering_items.order(correct_position: :asc).pluck(:id).map(&:to_s)

    submitted_ids == correct_ids
  end
end
