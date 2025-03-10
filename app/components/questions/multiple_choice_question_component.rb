require "ostruct"

class Questions::MultipleChoiceQuestionComponent < ViewComponent::Base
  def initialize(question: nil, form: nil, just_answered: false, mock: false)
    @mock = mock
    @question = mock ? mock_question : question
    @form = form
    @just_answered = just_answered
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def mock_question
    OpenStruct.new(
      prompt: "Which programming languages are commonly used for web development?",
      questionable: OpenStruct.new(correct_answer: true, options: [
      OpenStruct.new(id: 1, text: "Ruby", correct?: true, feedback: "Correct! Ruby is widely used with frameworks like Rails."),
      OpenStruct.new(id: 2, text: "JavaScript", correct?: true, feedback: "Correct! JavaScript is essential for frontend development."),
      OpenStruct.new(id: 3, text: "Python", correct?: true, feedback: "Correct! Python is popular with frameworks like Django."),
      OpenStruct.new(id: 4, text: "Assembly", correct?: false, feedback: "Incorrect! Assembly is rarely used in web development."),
      OpenStruct.new(id: 5, text: "COBOL", correct?: false, feedback: "Incorrect! COBOL is mainly used in legacy business systems.")
      ]),
      core_question: false,
    )
  end

  def latest_answer
    @latest_answer ||= @question.user_answers.where(user: current_user).last
  end

  def selected_options
    return [] unless @just_answered
    latest_answer&.answer_data&.dig("selected_options") || []
  end

  def feedback_for_option(option)
    return unless @just_answered
    selected = selected_options.any? { |so| so["id"] == option.id }
    if selected && !option.correct?
      option.feedback
    end
  end

  def question_answered?
    return false if @mock
    @question.user_answers.where(
      user: current_user,
      progression: @question.course.progressions.where(user: current_user).order(created_at: :desc).first
    ).exists?
  end
end
