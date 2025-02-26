require "test_helper"

class AnswersControllerTest < ActionDispatch::IntegrationTest
  class TrueFalseQuestions < AnswersControllerTest
    setup do
      @user = create(:user)
      @course = create(:course)

      @step1 = create(:step,
        :with_true_false_question,
        course: @course,
        question_prompt: "Is the sky blue?",
        correct_answer: true,
        position: 1
      )

      @step2 = create(:step,
        :with_true_false_question,
        course: @course,
        question_prompt: "Is water wet?",
        correct_answer: true,
        position: 2
      )

      @step3 = create(:step,
        :with_true_false_question,
        course: @course,
        question_prompt: "Is the earth flat?",
        correct_answer: false,
        position: 3
      )

      @progression = create(:progression,
        user: @user,
        course: @course,
        current_step: @step1
      )

      sign_in(@user)
    end

    test "redirects to next step when answer is correct" do
      answer_hash = { "question_#{@step1.questions.first.id}" => "true" }
      post course_step_answers_path(@course, @step1), params: { answer: answer_hash }

      assert_redirected_to course_step_path(@course, @step1, just_answered: true)
    end

    test "stays on same step when answer is incorrect" do
      answer_hash = { "question_#{@step1.questions.first.id}" => "false" }
      post course_step_answers_path(@course, @step1), params: { answer: answer_hash }

      assert_redirected_to course_step_path(@course, @step1, just_answered: true)
    end
  end
end
