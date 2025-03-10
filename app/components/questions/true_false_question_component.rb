require "ostruct"

class Questions::TrueFalseQuestionComponent < ViewComponent::Base
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
      prompt: "Standards help ensure consistency and quality across products and services.",
      questionable: OpenStruct.new(correct_answer: true),
      core_question: @core
    )
  end

  def correct_answer
    @question.questionable.correct_answer
  end

  def question_answered?
    return false if @mock
    @question.user_answers.where(
      user: current_user,
      progression: @question.course.progressions.where(user: current_user).order(id: :desc).first
    ).exists?
  end
end
