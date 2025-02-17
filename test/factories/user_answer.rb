FactoryBot.define do
  factory :user_answer do
    user
    question
    answer_data { {} }
    correct { false }
  end
end
