FactoryBot.define do
  factory :standard_certificate do
    association :user
    association :standard
    issue_date { Date.today }
    sequence(:certificate_number) { |n| "CERT-#{n}-#{Time.now.to_i}" }
    competency_level { "Proficient" }
  end
end
