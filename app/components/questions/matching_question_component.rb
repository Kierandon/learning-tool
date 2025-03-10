require "ostruct"

class Questions::MatchingQuestionComponent < ViewComponent::Base
  def initialize(question: nil, form: nil, just_answered: false, mock: false)
    @mock = mock
    @question = mock ? mock_question : question
    @form = form
    @just_answered = just_answered
    @pairs = @question.questionable.matching_pairs
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def mock_question
    OpenStruct.new(
      prompt: "Match the following terms with their definitions.",
      questionable: OpenStruct.new(
        matching_pairs: [
          OpenStruct.new(id: 1, term: "HTML", definition: "A markup language for creating web pages."),
          OpenStruct.new(id: 2, term: "CSS", definition: "A style sheet language used for describing the presentation of a document."),
          OpenStruct.new(id: 3, term: "JavaScript", definition: "A programming language commonly used in web development.")
        ]
      ),
      core_question: false
    )
  end

  def all_correct?
    return false unless @just_answered
    latest_answer&.correct
  end

  def incorrect_pairs
    return [] unless @just_answered
    latest_answer&.answer_data[:incorrect_pairs]
  end

  def question_answered?
    return false if @mock
    @question.user_answers.where(
      user: current_user,
      progression: @question.course.progressions.where(user: current_user).order(created_at: :desc).first
    ).exists?
  end

  def latest_answer
    @latest_answer ||= @question.user_answers.where(user: current_user).last
  end

  def success_message
    @question.questionable.success_message || "Correct! All pairs matched correctly!"
  end

  def failure_message
    @question.questionable.failure_message || "Some pairs were not matched correctly:"
  end
end
