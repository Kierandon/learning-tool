class Questions::TrueFalseQuestionComponent < ViewComponent::Base
  def initialize(question:, form:, just_answered: false)
    @question = question
    @form = form
    @just_answered = just_answered
  end

  def before_render
    @just_answered ||= question_answered?
  end

  private

  def correct_answer
    @question.questionable.correct_answer
  end

  def last_answer_correct?
    @question.user_answers.last.correct
  end

  def question_answered?
    @question.user_answers.where(user: current_user).exists?
  end
end
