class UserAnswerChoice < ApplicationRecord
  belongs_to :user_answer
  belongs_to :choice
end
