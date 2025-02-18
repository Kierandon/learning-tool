FactoryBot.define do
  factory :matching_pair do
    sequence(:term) { |n| "Term #{n}" }
    sequence(:definition) { |n| "Definition #{n}" }
    sequence(:position) { |n| n }
    matching_question
  end
end
