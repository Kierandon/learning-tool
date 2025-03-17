FactoryBot.define do
  factory :learning_objective do
    association :standard_section
    sequence(:objective_id) { |n| "objective-#{n}" }
    description { "Learn about something important" }
    completion_criteria { "Complete the associated tasks" }
  end
end
