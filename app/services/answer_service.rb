class AnswerService
  def initialize(question, user)
    @question = question
    @user = user
  end

  def process(submitted_answer)
    converted_answer = convert_answer(submitted_answer)
    result = @question.check_answer(converted_answer)

    answer_data = case @question.questionable_type
    when MatchingQuestion.to_s
      generate_matching_answer_data(submitted_answer)
    when MultipleChoiceQuestion.to_s
      generate_multiple_choice_answer_data(submitted_answer)
    when OrderingQuestion.to_s
      generate_ordering_answer_data(submitted_answer)
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
    when MultipleChoiceQuestion.to_s
      answer["selected_options"].flatten.map(&:to_i)
    when OrderingQuestion.to_s
      JSON.parse(answer["item_order"])
    else
      answer
    end
  end

  def generate_ordering_answer_data(submitted_answer)
    submitted_order = convert_answer(submitted_answer)
    correct_order = @question.questionable.ordering_items.order(correct_position: :asc)

    {
      submitted_order: submitted_order.map { |id|
        item = @question.questionable.ordering_items.find_by(id: id)
        {
          id: id,
          content: item&.content,
          correct_position: item&.correct_position
        }
      },
      correct_order: correct_order.map { |item|
        {
          id: item.id.to_s,
          content: item.content,
          position: item.correct_position
        }
      },
      is_correct: submitted_order.map(&:to_s) == correct_order.pluck(:id).map(&:to_s)
    }
  end

  def generate_multiple_choice_answer_data(submitted_answer)
    selected_ids = (submitted_answer["selected_options"] || []).flatten
    selected_options = @question.questionable.options.where(id: selected_ids)
    correct_options = @question.questionable.options.where(correct: true)

    {
      selected_options: selected_options.map { |option|
        {
          id: option.id,
          text: option.text,
          correct: option.correct,
          feedback: option.feedback
        }
      },
      correct_options: correct_options.map { |option|
        {
          id: option.id,
          text: option.text
        }
      }
    }
  end

  def generate_matching_answer_data(submitted_pairs)
    incorrect_pairs = []

    submitted_pairs.each do |term_key, selected_definition_id|
      next unless term_key.start_with?("term_")

      term_id = term_key.split("_").last
      pair = @question.questionable.matching_pairs.find_by(id: term_id)
      next unless pair

      if selected_definition_id.blank?
        incorrect_pairs << {
          "term" => pair.term,
          "correct_definition" => pair.definition,
          "selected_definition" => "No selection"
        }
      elsif pair.id.to_s != selected_definition_id
        selected_pair = @question.questionable.matching_pairs.find_by(id: selected_definition_id)
        selected_definition = selected_pair&.definition || "Invalid selection"

        incorrect_pairs << {
          "term" => pair.term,
          "correct_definition" => pair.definition,
          "selected_definition" => selected_definition
        }
      end
    end

    { incorrect_pairs: incorrect_pairs }
  end
end
