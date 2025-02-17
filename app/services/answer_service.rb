class AnswerService
  def initialize(question, user)
    @question = question
    @user = user
  end

  def process(submitted_answer)
    converted_answer = convert_answer(submitted_answer)
    result = @question.check_answer(converted_answer)
    answer = @question.user_answers.create!(
      user: @user,
      answer_data: submitted_answer.to_h,
      correct: result
    )
    answer
  end

  private

  def convert_answer(answer)
    case @question.questionable_type
    when TrueFalseQuestion.to_s
      answer_value = answer["question_#{@question.id}"]
      answer_value.to_s.downcase == "true"
    else
      answer
    end
  end
end
