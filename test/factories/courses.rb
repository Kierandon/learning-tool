FactoryBot.define do
  factory :course do
    title { "Sample Course" }
    description { "This is a sample description." }
    image_url { "https://placehold.co/600x400" }
    ordering { 1 }

    after(:create) do |course|
      create_list(:step, 2, course: course)
    end
  end
end
