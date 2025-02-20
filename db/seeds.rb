course = Course.create!(
  title: "Introduction to Programming",
  description: "Learn the basics of programming concepts",
  image_url: "https://placehold.co/600x400"
)

badge = course.create_badge!(
  name: "Programming Fundamentals",
  description: ActionText::Content.new(<<-HTML
    <div>
      <p>Awarded for completing the Introduction to Programming course and demonstrating understanding of basic programming concepts.</p>
    </div>
  HTML
  )
)

badge.image.attach(
  io: File.open(Rails.root.join("app/assets/images/default-badge.jpg")),
  filename: "default-badge.jpg",
  content_type: "image/jpg"
)

# Create an info step
info_step = course.steps.create!(
  title: "What is Programming?",
  position: 1,
  step_type: "info",
  content: ActionText::Content.new(<<-HTML
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
)

# Create a step with a true/false question
true_false_step = course.steps.create!(
  title: "True or False",
  step_type: "question",
  position: 2
)

tf_question = true_false_step.questions.create!(
  prompt: "Programming is only about writing code.",
  position: 1,
  questionable: TrueFalseQuestion.create!(
    correct_answer: false,
    success_message: "Correct! Programming involves many other skills like problem-solving and design.",
    failure_message: "Actually, programming involves much more than just writing code!"
  )
)

# Create a step with a multiple choice question
multiple_choice_step = course.steps.create!(
  title: "Multiple Choice",
  step_type: "question",
  position: 3
)

mc_question = multiple_choice_step.questions.create!(
  prompt: "Which of these is NOT a programming language?",
  position: 1,
  questionable: MultipleChoiceQuestion.create!(
    allow_multiple_answers: false,
    success_message: "Correct! CoffeeScript+ is not a real programming language.",
    failure_message: "That's not right. Try again!"
  )
)

# Add options to multiple choice question
mc_question.questionable.options.create!([
  { text: "Python", correct: false, feedback: "Python is a popular programming language." },
  { text: "JavaScript", correct: false, feedback: "JavaScript is a widely-used web programming language." },
  { text: "CoffeeScript+", correct: true, feedback: "This is not a real programming language!" },
  { text: "Ruby", correct: false, feedback: "Ruby is a programming language." }
])

# Create a step with a matching question (dropdown type)
matching_dropdown_step = course.steps.create!(
  title: "Match the Terms (Dropdown)",
  step_type: "question",
  position: 4
)

dropdown_matching = MatchingQuestion.create!(
  matching_style: "dropdown",
  success_message: "Great job matching the programming terms!",
  failure_message: "Some matches are incorrect. Try again!"
)

matching_dropdown_step.questions.create!(
  prompt: "Match each programming term with its definition",
  position: 1,
  questionable: dropdown_matching
)

# Add pairs to dropdown matching question
dropdown_matching.matching_pairs.create!([
  { term: "Variable", definition: "A container for storing data values", position: 1 },
  { term: "Function", definition: "A reusable block of code", position: 2 },
  { term: "Loop", definition: "Code that repeats until a condition is met", position: 3 }
])

# Create a step with a matching question (drawing type)
matching_drawing_step = course.steps.create!(
  title: "Match the Terms (Drawing)",
  step_type: "question",
  position: 5
)

drawing_matching = MatchingQuestion.create!(
  matching_style: "drawing",
  success_message: "Excellent work connecting the concepts!",
  failure_message: "Some connections are incorrect. Try again!"
)

matching_drawing_step.questions.create!(
  prompt: "Draw lines to connect related programming concepts",
  position: 1,
  questionable: drawing_matching
)

# Add pairs to drawing matching question
drawing_matching.matching_pairs.create!([
  { term: "HTML", definition: "Structure", position: 1 },
  { term: "CSS", definition: "Style", position: 2 },
  { term: "JavaScript", definition: "Behavior", position: 3 }
])
