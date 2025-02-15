FactoryBot.define do
  factory :step do
    course
    title { "Default Step" }
    step_type { "info" }
    content { "This is a default step." }
    position { 0 }
  end
end
