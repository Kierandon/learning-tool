FactoryBot.define do
  factory :question do
    association :step
    prompt { "What is 2 + 2?" }
    position { 1 }

    trait :true_false do
      questionable { build(:true_false_question) }
    end
  end
end
