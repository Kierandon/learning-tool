course = Course.find_or_create_by!(
  title: "Introduction to Programming"
) do |c|
  c.description = "Learn the basics of programming concepts"
  c.image_url = "https://placehold.co/600x400"
end

badge = course.badge || course.create_badge!(
  name: "Programming Fundamentals",
  description: ActionText::Content.new(<<-HTML
    <div>
      <p>Awarded for completing the Introduction to Programming course and demonstrating understanding of basic programming concepts.</p>
    </div>
  HTML
  )
)

unless badge.image.attached?
  badge.image.attach(
    io: File.open(Rails.root.join("app/assets/images/default-badge.jpg")),
    filename: "default-badge.jpg",
    content_type: "image/jpg"
  )
end

# Create or find an info step
info_step = course.steps.find_or_create_by!(
  title: "What is Programming?",
  step_type: "info"
) do |step|
  step.position = 1
  step.content = ActionText::Content.new(<<-HTML
    <div>
      <h1>Introduction to Programming</h1>
      <p>Programming is the process of creating a set of instructions that tell a computer how to perform a task.</p>
      <p>In this course, you'll learn about:</p>
      <ul>
        <li>Basic programming concepts</li>
        <li>How computers execute instructions</li>
        <li>Different types of programming languages</li>
      </ul>
    </div>
  HTML
  )
end

# True/False question step
true_false_step = course.steps.find_or_create_by!(
  title: "True or False",
  step_type: "question"
) do |step|
  step.position = 2
end

tf_question = true_false_step.questions.find_or_create_by!(
  prompt: "Programming is only about writing code.",
  position: 1
) do |q|
  q.questionable = TrueFalseQuestion.find_or_create_by!(
    correct_answer: false,
    success_message: "Correct! Programming involves many other skills like problem-solving and design.",
    failure_message: "Actually, programming involves much more than just writing code!"
  )
end

# Multiple Choice question step
multiple_choice_step = course.steps.find_or_create_by!(
  title: "Multiple Choice",
  step_type: "question"
) do |step|
  step.position = 3
end

mc_question = multiple_choice_step.questions.find_or_create_by!(
  prompt: "Which of these is NOT a programming language?",
  position: 1
) do |q|
  q.questionable = MultipleChoiceQuestion.find_or_create_by!(
    allow_multiple_answers: false,
    success_message: "Correct! CoffeeScript+ is not a real programming language.",
    failure_message: "That's not right. Try again!"
  )
end

# Add multiple choice options
options = [
  { text: "Python", correct: false, feedback: "Python is a popular programming language." },
  { text: "JavaScript", correct: false, feedback: "JavaScript is a widely-used web programming language." },
  { text: "CoffeeScript+", correct: true, feedback: "This is not a real programming language!" },
  { text: "Ruby", correct: false, feedback: "Ruby is a programming language." }
]
options.each do |option|
  mc_question.questionable.options.find_or_create_by!(text: option[:text]) do |o|
    o.correct = option[:correct]
    o.feedback = option[:feedback]
  end
end

# Dropdown matching question step
matching_dropdown_step = course.steps.find_or_create_by!(
  title: "Match the Terms (Dropdown)",
  step_type: "question"
) do |step|
  step.position = 4
end

dropdown_matching = MatchingQuestion.find_or_create_by!(
  matching_style: "dropdown",
  success_message: "Great job matching the programming terms!",
  failure_message: "Some matches are incorrect. Try again!"
)

matching_dropdown_step.questions.find_or_create_by!(
  prompt: "Match each programming term with its definition",
  position: 1,
  questionable: dropdown_matching
)

# Add dropdown matching pairs
pairs = [
  { term: "Variable", definition: "A container for storing data values", position: 1 },
  { term: "Function", definition: "A reusable block of code", position: 2 },
  { term: "Loop", definition: "Code that repeats until a condition is met", position: 3 }
]
pairs.each do |pair|
  dropdown_matching.matching_pairs.find_or_create_by!(term: pair[:term]) do |p|
    p.definition = pair[:definition]
    p.position = pair[:position]
  end
end

# Drawing matching question step
matching_drawing_step = course.steps.find_or_create_by!(
  title: "Match the Terms (Drawing)",
  step_type: "question"
) do |step|
  step.position = 5
end

drawing_matching = MatchingQuestion.find_or_create_by!(
  matching_style: "drawing",
  success_message: "Excellent work connecting the concepts!",
  failure_message: "Some connections are incorrect. Try again!"
)

matching_drawing_step.questions.find_or_create_by!(
  prompt: "Draw lines to connect related programming concepts",
  position: 1,
  questionable: drawing_matching
)

# Add drawing matching pairs
drawing_pairs = [
  { term: "HTML", definition: "Structure", position: 1 },
  { term: "CSS", definition: "Style", position: 2 },
  { term: "JavaScript", definition: "Behavior", position: 3 }
]
drawing_pairs.each do |pair|
  drawing_matching.matching_pairs.find_or_create_by!(term: pair[:term]) do |p|
    p.definition = pair[:definition]
    p.position = pair[:position]
  end
end
