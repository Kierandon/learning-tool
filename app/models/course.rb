class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :ordering, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, uniqueness: true
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }, allow_blank: true
end
