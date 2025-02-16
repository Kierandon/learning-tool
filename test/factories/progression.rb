FactoryBot.define do
  factory :progression do
    user
    course

    trait :progression_with_steps do
      after(:create) do |progression|
        create(:step, course: progression.course, position: 1)
        create(:step, course: progression.course, position: 2)
      end
    end
  end
end
