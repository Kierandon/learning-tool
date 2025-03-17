FactoryBot.define do
  factory :achievement do
    achievement_type { "question_count" }
    sequence(:name) { |n| "Achievement #{n}" }
    description { "This is a test achievement" }
    threshold { 5 }
  end
end
