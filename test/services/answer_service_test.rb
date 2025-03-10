require "test_helper"

class AnswerServiceTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @question = create(:question, :true_false)
    @progression = create(:progression, user: @user)
    @service = AnswerService.new(@question, @user, @progression)
  end

  test "processes true/false answer correctly when answer is correct" do
    correct_answer = @question.questionable.correct_answer

    submitted_answer = { "question_#{@question.id}" => correct_answer.to_s }
    result = @service.process(submitted_answer)

    assert result.correct?
    assert_equal submitted_answer, result.answer_data
    assert_equal @user, result.user
    assert_equal @question, result.question
  end

  test "processes true/false answer correctly when answer is incorrect" do
    correct_answer = @question.questionable.correct_answer
    wrong_answer = !correct_answer

    submitted_answer = { "question_#{@question.id}" => wrong_answer.to_s }
    result = @service.process(submitted_answer)

    assert_not result.correct?
    assert_equal submitted_answer, result.answer_data
    assert_equal @user, result.user
    assert_equal @question, result.question
  end

  test "handles case-insensitive true/false answers" do
    correct_answer = @question.questionable.correct_answer

    submitted_answer = { "question_#{@question.id}" => correct_answer.to_s.upcase }
    result = @service.process(submitted_answer)

    assert result.correct?
  end

  test "creates user_answer record in database" do
    submitted_answer = { "question_#{@question.id}" => "true" }

    assert_difference -> { UserAnswer.count }, 1 do
      @service.process(submitted_answer)
    end
  end
end
