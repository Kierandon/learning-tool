require "test_helper"

class TrueFalseQuestionTest < ActiveSupport::TestCase
  test "correctly checks true/false answers" do
    question = create(:question, :true_false, questionable_attributes: { correct_answer: true })

    assert question.check_answer(true)
    assert_not question.check_answer(false)
  end
end
