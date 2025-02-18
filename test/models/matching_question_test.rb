require "test_helper"

class MatchingQuestionTest < ActiveSupport::TestCase
  test "validates correct matching answers" do
    question = create(:matching_question)
    pair1 = create(:matching_pair, matching_question: question)
    pair2 = create(:matching_pair, matching_question: question)

    correct_answers = {
      "term_#{pair1.id}" => pair1.id.to_s,
      "term_#{pair2.id}" => pair2.id.to_s
    }

    incorrect_answers = {
      "term_#{pair1.id}" => pair2.id.to_s,
      "term_#{pair2.id}" => pair1.id.to_s
    }

    assert question.correct_answer?(correct_answers)
    assert_not question.correct_answer?(incorrect_answers)
  end
end
