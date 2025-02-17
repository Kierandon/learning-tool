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

      assert_redirected_to course_step_path(@course, @step2)
      assert_equal "Correct!", flash[:notice]
      @progression.reload
      assert_equal @step2, @progression.current_step
    end

    test "stays on same step when answer is incorrect" do
      answer_hash = { "question_#{@step1.questions.first.id}" => "false" }
      post course_step_answers_path(@course, @step1), params: { answer: answer_hash }

      assert_redirected_to course_step_path(@course, @step1)
      assert_equal "Incorrect!", flash[:alert]
      @progression.reload
      assert_equal @step1, @progression.current_step
    end

    test "completes course when correctly answering final step" do
      @progression.update!(current_step: @step3)
      answer_hash = { "question_#{@step3.questions.first.id}" => "false" }
      post course_step_answers_path(@course, @step3), params: { answer: answer_hash }

      assert_redirected_to course_path(@course)
      assert_match(/Course completed!/, flash[:notice])
    end

    test "progresses through all steps correctly" do
      # Step 1 -> 2
      answer_hash1 = { "question_#{@step1.questions.first.id}" => "true" }
      post course_step_answers_path(@course, @step1), params: { answer: answer_hash1 }
      assert_redirected_to course_step_path(@course, @step2)
      @progression.reload
      assert_equal @step2, @progression.current_step

      # Step 2 -> 3
      answer_hash2 = { "question_#{@step2.questions.first.id}" => "true" }
      post course_step_answers_path(@course, @step2), params: { answer: answer_hash2 }
      assert_redirected_to course_step_path(@course, @step3)
      @progression.reload
      assert_equal @step3, @progression.current_step

      # Step 3 -> Complete
      answer_hash3 = { "question_#{@step3.questions.first.id}" => "false" }
      post course_step_answers_path(@course, @step3), params: { answer: answer_hash3 }
      assert_redirected_to course_path(@course)
    end
  end
end
