class StandardCertificate < ApplicationRecord
  belongs_to :user
  belongs_to :standard

  validates :certificate_number, presence: true, uniqueness: true
  validates :issue_date, presence: true
  validates :competency_level, presence: true
end
