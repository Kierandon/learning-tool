class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :image_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
end
