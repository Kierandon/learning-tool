FactoryBot.define do
  factory :standard do
    name { "Sample Standard" }
    code { "SAMPLE-#{SecureRandom.hex(4)}" }
    visibility { "true" }
    url { "https://placehold.co/600x400" }
  end
end
