FactoryBot.define do
  factory :matching_question do
    trait :with_pairs do
      after(:create) do |question|
        create(:matching_pair, 
          matching_question: question,
          term: "Ruby",
          definition: "A dynamic programming language",
          position: 1
        )
        create(:matching_pair,
          matching_question: question,
          term: "Python",
          definition: "A versatile scripting language",
          position: 2
        )
      end
    end
  end
end
