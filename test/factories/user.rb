FactoryBot.define do
  factory :user do
    type { "User" }

    trait :admin do
      type { "AdminUser" }
    end
  end
end
