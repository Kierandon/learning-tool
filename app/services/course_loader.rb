require "yaml"

class CourseLoader
  def self.load_from_yaml(yaml_path)
    new.load_from_yaml(yaml_path)
  end

  def self.load_all_from_directory(directory_path)
    Dir.glob(File.join(directory_path, "*.yml")).each do |yaml_file|
      new.load_from_yaml(yaml_file)
    end
  end

  def load_from_yaml(yaml_path)
    course_data = YAML.load_file(yaml_path).deep_symbolize_keys
    create_course_from_data(course_data)
  end

  private

  def create_course_from_data(data)
    course_data = data[:course]
    standard = Standard.find_by(code: course_data[:standard]) if course_data[:standard].present?
    course = Course.create!(
      title: course_data[:title],
      description: course_data[:description],
      image_url: course_data[:image_url],
      standard: standard
    )

    create_badge(course, data[:badge]) if data[:badge]
    data[:steps]&.each { |step_data| create_step(course, step_data) }

    course
  end

  def create_step(course, step_data)
    step_type = step_data[:type]
    title = step_data[:title]

    step = case step_type
    when "info"
      course.steps.create!(
        title: title,
        step_type: "info",
        content: ActionText::Content.new(step_data[:content])
      )
    when "true_false", "multiple_choice", "matching", "ordering"
      step = create_question_step(course, title)
      send("create_#{step_type}_question", step, step_data)
      step
    else
      Rails.logger.warn("Unknown step type: #{step_type}")
      nil
    end

    if step_data[:fulfills_objectives]
      step.fulfills_objectives(step_data[:fulfills_objectives])
    end

    step
  end

  def create_badge(course, badge_data)
    badge = course.badge || course.create_badge!(
      name: badge_data[:name],
      description: ActionText::Content.new(badge_data[:description])
    )

    attach_badge_image(badge, badge_data[:image_path] || "app/assets/images/default-badge.jpg") unless badge.image.attached?
  end

  def attach_badge_image(badge, image_path)
    badge.image.attach(
      io: File.open(Rails.root.join(image_path)),
      filename: File.basename(image_path),
      content_type: "image/#{File.extname(image_path).delete('.')}"
    )
  end

  def create_question_step(course, step_title)
    course.steps.create!(title: step_title, step_type: "question")
  end

  def create_true_false_question(step, data)
    step.questions.create!(
      prompt: data[:prompt],
      questionable: TrueFalseQuestion.create!(
        correct_answer: data[:correct_answer],
        success_message: data[:success_message],
        failure_message: data[:failure_message]
      )
    )
  end

  def create_multiple_choice_question(step, data)
    question = step.questions.create!(
      prompt: data[:prompt],
      questionable: MultipleChoiceQuestion.new(
        allow_multiple_answers: data[:allow_multiple_answers] || false,
        success_message: data[:success_message],
        failure_message: data[:failure_message]
      ).tap { |q| q.save!(validate: false) }
    )

    data[:options].each do |option|
      question.questionable.options.create!(
        correct: option[:correct],
        feedback: option[:feedback],
        text: option[:text]
      )
    end
  end

  def create_matching_question(step, data)
    question = step.questions.create!(
      prompt: data[:prompt],
      questionable: MatchingQuestion.create!(
        matching_style: data[:matching_style] || "dropdown",
        success_message: data[:success_message],
        failure_message: data[:failure_message]
      )
    )

    data[:pairs].each do |pair|
      question.questionable.matching_pairs.create!(
        term: pair[:term],
        definition: pair[:definition],
        position: pair[:position]
      )
    end
  end

  def create_ordering_question(step, data)
    question = step.questions.create!(
      prompt: data[:prompt],
      questionable: OrderingQuestion.create!(
        success_message: data[:success_message],
        failure_message: data[:failure_message]
      )
    )

    data[:items].each do |item|
      question.questionable.ordering_items.create!(
        content: item[:content],
        correct_position: item[:correct_position]
      )
    end
  end
end
