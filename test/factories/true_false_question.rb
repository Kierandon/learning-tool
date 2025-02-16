FactoryBot.define do
  factory :true_false_question do
    correct_answer { [ true, false ].sample }
  end
end
