FactoryBot.define do
  factory :standard_section do
    association :standard
    sequence(:section_id) { |n| "section-#{n}" }
    name { "Standard Section" }
    url { "http://example.com/section" }
    description { "This is a test section" }
  end
end
