class AnswerService
  def initialize(question, user)
    @question = question
    @user = user
  end

  def process(submitted_answer)
    converted_answer = convert_answer(submitted_answer)
    result = @question.check_answer(converted_answer)

    answer_data = if @question.questionable_type == MatchingQuestion.to_s
      generate_matching_answer_data(submitted_answer)
    else
      submitted_answer.to_h
    end

    answer = @question.user_answers.create!(
      user: @user,
      answer_data: answer_data,
      correct: result
    )
    answer
  end

  private

  def convert_answer(answer)
    case @question.questionable_type
    when MatchingQuestion.to_s
      answer
    when TrueFalseQuestion.to_s
      answer_value = answer["question_#{@question.id}"]
      answer_value.to_s.downcase == "true"
    else
      answer
    end
  end

  def generate_matching_answer_data(submitted_pairs)
    incorrect_pairs = []

    submitted_pairs.each do |term_key, selected_definition_id|
      term_id = term_key.split("_").last
      pair = @question.questionable.matching_pairs.find(term_id)

      if pair.id.to_s != selected_definition_id
        selected_pair = @question.questionable.matching_pairs.find(selected_definition_id)
        incorrect_pairs << {
          "term" => pair.term,
          "correct_definition" => pair.definition,
          "selected_definition" => selected_pair.definition
        }
      end
    end

    { incorrect_pairs: incorrect_pairs }
  end
end
