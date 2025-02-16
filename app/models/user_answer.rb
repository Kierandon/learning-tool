class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :answer_data, presence: true
end
