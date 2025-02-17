FactoryBot.define do
  factory :step do
    course
    title { "Default Step" }
    step_type { "info" }
    content { "This is a default step." }
    position { 1 }

    trait :with_true_false_question do
      transient do
        question_prompt { "Is this true?" }
        correct_answer { true }
      end

      after(:create) do |step, evaluator|
        create(:question, :true_false,
          step: step,
          prompt: evaluator.question_prompt,
          questionable: build(:true_false_question, correct_answer: evaluator.correct_answer)
        )
      end
    end
  end
end
