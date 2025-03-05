module CourseHelper
  # Create or update an info step
  def create_info_step(course, title, position, content_html)
    course.steps.find_or_create_by!(
      title: title,
      position: position,
      step_type: "info"
    ) do |step|
      step.position = position
      step.content = ActionText::Content.new(content_html)
    end
  end

  # Create or update a true/false question step
  def create_true_false_step(course, step_title, position, question_data)
    step = course.steps.find_or_create_by!(
      title: step_title,
      position: position,
      step_type: "question"
    ) do |s|
      s.position = position
    end

    step.questions.find_or_create_by!(
      prompt: question_data[:prompt],
      position: question_data[:question_position] || 1
    ) do |q|
      q.questionable = TrueFalseQuestion.find_or_create_by!(
        correct_answer: question_data[:correct_answer],
        success_message: question_data[:success_message],
        failure_message: question_data[:failure_message]
      )
    end

    step
  end

  # Create or update a multiple choice question step
  def create_multiple_choice_step(course, step_title, position, question_data)
    step = course.steps.find_or_create_by!(
      title: step_title,
      position: position,
      step_type: "question"
    ) do |s|
      s.position = position
    end

    mc_question = step.questions.find_or_create_by!(
      prompt: question_data[:prompt],
      position: question_data[:question_position] || 1
    ) do |q|
      q.questionable = MultipleChoiceQuestion.find_or_create_by!(
        allow_multiple_answers: question_data[:allow_multiple_answers] || false,
        success_message: question_data[:success_message],
        failure_message: question_data[:failure_message]
      )
    end

    # Add options
    question_data[:options].each do |option|
      mc_question.questionable.options.find_or_create_by!(text: option[:text]) do |o|
        o.correct = option[:correct]
        o.feedback = option[:feedback]
      end
    end

    step
  end

  # Create or update a matching question step
  def create_matching_step(course, step_title, position, question_data)
    step = course.steps.find_or_create_by!(
      title: step_title,
      position: position,
      step_type: "question"
    ) do |s|
      s.position = position
    end

    matching = MatchingQuestion.find_or_create_by!(
      matching_style: question_data[:matching_style] || "dropdown",
      success_message: question_data[:success_message],
      failure_message: question_data[:failure_message]
    )

    step.questions.find_or_create_by!(
      prompt: question_data[:prompt],
      position: question_data[:question_position] || 1,
      questionable: matching
    )

    # Add matching pairs
    question_data[:pairs].each do |pair|
      matching.matching_pairs.find_or_create_by!(term: pair[:term]) do |p|
        p.definition = pair[:definition]
        p.position = pair[:position]
      end
    end

    step
  end

  # Create or update an ordering question step
  def create_ordering_step(course, step_title, position, question_data)
    step = course.steps.find_or_create_by!(
      title: step_title,
      position: position,
      step_type: "question"
    ) do |s|
      s.position = position
    end

    ordering = OrderingQuestion.find_or_create_by!(
      success_message: question_data[:success_message],
      failure_message: question_data[:failure_message]
    )

    step.questions.find_or_create_by!(
      prompt: question_data[:prompt],
      position: question_data[:question_position] || 1,
      questionable: ordering
    )

    # Add ordering items
    question_data[:items].each do |item|
      ordering.ordering_items.find_or_create_by!(content: item[:content]) do |i|
        i.correct_position = item[:correct_position]
      end
    end

    step
  end

  # Create or update a badge for a course
  def create_badge(course, name, description_html, image_path)
    badge = course.badge || course.create_badge!(
      name: name,
      description: ActionText::Content.new(description_html)
    )

    unless badge.image.attached?
      badge.image.attach(
        io: File.open(Rails.root.join(image_path)),
        filename: File.basename(image_path),
        content_type: "image/#{File.extname(image_path).delete('.')}"
      )
    end

    badge
  end
end
