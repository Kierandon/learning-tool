FactoryBot.define do
  factory :user_achievement do
    association :user
    association :achievement
    awarded_at { Time.current }
  end
end
