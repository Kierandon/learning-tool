class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :progression

  validates :answer_data, presence: true
  serialize :answer_data, type: Hash, coder: YAML
end
