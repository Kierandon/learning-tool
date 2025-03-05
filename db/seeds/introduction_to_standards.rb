course = Course.find_or_create_by!(
  title: "Introduction to Software Standards"
) do |c|
  c.description = "Learn how software standards support consistency and quality in engineering."
  c.image_url = "https://placehold.co/600x400?text=Software+Standards"
end

badge = course.badge || course.create_badge!(
  name: "Standards Specialist",
  description: ActionText::Content.new(<<-HTML
    <div class="p-4">
      <p class="mb-2">Awarded for completing the Introduction to Software Standards course, showing awareness of why standards exist and how to apply them.</p>
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

# Step 1: Introduction
info_step_1 = course.steps.find_or_create_by!(
  title: "Introduction to Software Standards",
  step_type: "info"
) do |step|
  step.position = 1
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">What Are Software Standards?</h2>
      <p class="mb-4">They are guidelines set by groups like ISO and IEEE to ensure consistency, safety, and common approaches in software development.</p>
      <p>In this course, you’ll learn:</p>
      <ul class="list-disc list-inside mt-2">
        <li>Why these standards exist</li>
        <li>How they affect software teams</li>
        <li>Common standard categories</li>
        <li>Tips on adopting them</li>
      </ul>
    </div>
  HTML
  )
end

# Step 2: Why Standards?
info_step_2 = course.steps.find_or_create_by!(
  title: "Why Do Software Standards Exist?",
  step_type: "info"
) do |step|
  step.position = 2
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">Why Do Software Standards Exist?</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
        <div class="p-4 border rounded">
          <h3 class="font-bold mb-2">Consistency</h3>
          <p>Standards keep software development consistent across regions and organisations.</p>
        </div>
        <div class="p-4 border rounded">
          <h3 class="font-bold mb-2">Quality & Reliability</h3>
          <p>They help teams follow well-tested practices to ensure better outcomes.</p>
        </div>
        <div class="p-4 border rounded">
          <h3 class="font-bold mb-2">Risk Control</h3>
          <p>By following agreed procedures, projects have fewer surprises and issues.</p>
        </div>
        <div class="p-4 border rounded">
          <h3 class="font-bold mb-2">Common Terminology</h3>
          <p>Standards provide a shared language so everyone knows what to expect.</p>
        </div>
      </div>
      <blockquote class="border-l-4 border-blue-400 pl-4 italic">
        "ISO standards help make products and systems safe and dependable."
      </blockquote>
    </div>
  HTML
  )
end

# Step 3: Impact on Software Engineering
info_step_3 = course.steps.find_or_create_by!(
  title: "Impact on Software Engineering",
  step_type: "info"
) do |step|
  step.position = 3
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">Impact on Software Engineering</h2>
      <ul class="list-disc list-inside mb-4">
        <li>Higher software quality due to consistent rules</li>
        <li>Better structure for design, coding, and testing</li>
        <li>Stronger customer confidence and trust</li>
        <li>Smoother collaboration with other teams</li>
      </ul>
      <div class="mt-4 p-4 bg-gray-100">
        <h3 class="font-semibold mb-2">Development Phases:</h3>
        <p>Requirements → Design → Implementation → Testing → Maintenance</p>
        <p class="text-sm text-gray-600">Standards guide each phase.</p>
      </div>
    </div>
  HTML
  )
end

# Step 4: ISO Overview
info_step_4 = course.steps.find_or_create_by!(
  title: "International Organization for Standardization (ISO)",
  step_type: "info"
) do |step|
  step.position = 4
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">ISO Basics</h2>
      <p class="mb-4">ISO is an independent group based in Geneva, creating standards used worldwide. Notable standards include:</p>
      <table class="w-full table-auto border-collapse">
        <thead class="bg-blue-500 text-white">
          <tr>
            <th class="p-2">Standard</th>
            <th class="p-2">Focus</th>
          </tr>
        </thead>
        <tbody>
          <tr class="border-b">
            <td class="p-2">ISO 9001</td>
            <td class="p-2">Quality Management</td>
          </tr>
          <tr class="border-b">
            <td class="p-2">ISO/IEC 12207</td>
            <td class="p-2">Software Life Cycle</td>
          </tr>
          <tr class="border-b">
            <td class="p-2">ISO/IEC 27001</td>
            <td class="p-2">Security</td>
          </tr>
          <tr class="border-b">
            <td class="p-2">ISO/IEC 29119</td>
            <td class="p-2">Testing</td>
          </tr>
        </tbody>
      </table>
    </div>
  HTML
  )
end

# Step 5: IEEE Overview
info_step_5 = course.steps.find_or_create_by!(
  title: "Institute of Electrical and Electronics Engineers (IEEE)",
  step_type: "info"
) do |step|
  step.position = 5
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">IEEE Basics</h2>
      <p class="mb-4">The IEEE sets engineering standards across electrical, electronic, and computing fields. Examples include:</p>
      <div class="grid md:grid-cols-2 gap-4">
        <div class="border p-4">
          <h3 class="font-bold">IEEE 730</h3>
          <p>Guidance on Software Quality Assurance.</p>
        </div>
        <div class="border p-4">
          <h3 class="font-bold">IEEE 829</h3>
          <p>Detailed format for test documents.</p>
        </div>
        <div class="border p-4">
          <h3 class="font-bold">IEEE 1012</h3>
          <p>Verification & Validation guidelines.</p>
        </div>
        <div class="border p-4">
          <h3 class="font-bold">IEEE 1061</h3>
          <p>Metrics for measuring software quality.</p>
        </div>
      </div>
    </div>
  HTML
  )
end

# Step 6: Categories of Standards
info_step_6 = course.steps.find_or_create_by!(
  title: "Major Categories of Software Standards",
  step_type: "info"
) do |step|
  step.position = 6
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">Major Categories</h2>
      <ul class="list-disc list-inside mb-4">
        <li>Process (e.g., ISO/IEC 12207)</li>
        <li>Quality (e.g., ISO 9001)</li>
        <li>Security (e.g., ISO/IEC 27001)</li>
        <li>Testing (e.g., ISO/IEC/IEEE 29119)</li>
        <li>Documentation (e.g., IEEE 829)</li>
      </ul>
      <p>Each category addresses different parts of the development journey.</p>
    </div>
  HTML
  )
end

# Step 7: True/False Question
tf_step = course.steps.find_or_create_by!(
  title: "Standards and Innovation",
  step_type: "question"
) do |step|
  step.position = 7
end

tf_question = tf_step.questions.find_or_create_by!(
  prompt: "\"Software standards stifle innovation by forcing everyone to do things the same way.\"",
  position: 1
) do |q|
  q.questionable = TrueFalseQuestion.find_or_create_by!(
    correct_answer: false,
    success_message: "Correct! Standards form a baseline for good practice and do not remove creative problem-solving. They create stability that allows new ideas to grow.",
    failure_message: "Not quite. Standards do not remove creativity. They provide established principles, leaving room for new features and methods."
  )
end

# Step 8: Multiple Choice Question
mc_step = course.steps.find_or_create_by!(
  title: "Benefits of Standards",
  step_type: "question"
) do |step|
  step.position = 8
end

mc_question = mc_step.questions.find_or_create_by!(
  prompt: "Which of the following is a true benefit of using software standards?",
  position: 1
) do |q|
  q.questionable = MultipleChoiceQuestion.find_or_create_by!(
    allow_multiple_answers: false,
    success_message: "Correct! Standards improve software quality by providing reliable practices.",
    failure_message: "Try again. Think about how standards help teams achieve better outcomes."
  )
end

options = [
  { text: "They remove the need for testing.", correct: false, feedback: "Standards reinforce testing—they don't eliminate it." },
  { text: "They improve quality and reliability.", correct: true, feedback: "Yes! This is a core reason for using standards." },
  { text: "They guarantee success with no management.", correct: false, feedback: "Management is still essential for a successful project." },
  { text: "They cause confusion and chaos.", correct: false, feedback: "Standards reduce disorder by clarifying expectations." }
]

options.each do |option|
  mc_question.questionable.options.find_or_create_by!(text: option[:text]) do |o|
    o.correct = option[:correct]
    o.feedback = option[:feedback]
  end
end

# Step 9: Implementation
info_step_9 = course.steps.find_or_create_by!(
  title: "Implementing and Complying with Standards",
  step_type: "info"
) do |step|
  step.position = 9
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">Implementation Basics</h2>
      <ol class="list-decimal list-inside mb-4">
        <li>Assess your current processes</li>
        <li>Create a plan and assign responsibilities</li>
        <li>Train team members and pilot the changes</li>
        <li>Check compliance with audits or reviews</li>
      </ol>
      <div class="my-4 p-4 bg-gray-100">
        <h3 class="font-bold">Certification</h3>
        <p>For formal certifications (e.g., ISO 9001), expect an external audit, regular check-ups, and documented processes.</p>
      </div>
      <p class="mt-4">Standards can be voluntary or required by law. Even voluntary ones often bring better consistency and results.</p>
    </div>
  HTML
  )
end

# Step 10: Another True/False
tf_step_2 = course.steps.find_or_create_by!(
  title: "Standards for All Companies",
  step_type: "question"
) do |step|
  step.position = 10
end

tf_question_2 = tf_step_2.questions.find_or_create_by!(
  prompt: "\"Standards are only for big or heavily regulated companies. Smaller teams see little benefit.\"",
  position: 1
) do |q|
  q.questionable = TrueFalseQuestion.find_or_create_by!(
    correct_answer: false,
    success_message: "Correct! Even small teams gain from using standards to reduce errors and maintain consistency.",
    failure_message: "That’s not accurate. Standards can help any team, large or small, achieve more predictable and safer software outcomes."
  )
end

# Step 11: Matching Exercise
matching_step = course.steps.find_or_create_by!(
  title: "Match Standards to Descriptions",
  step_type: "question"
) do |step|
  step.position = 11
end

matching_question = MatchingQuestion.find_or_create_by!(
  matching_style: "drawing",
  success_message: "Great! Each standard aligns with its description.",
  failure_message: "Some are mismatched. Try again."
)

matching_step.questions.find_or_create_by!(
  prompt: "Match each standard to its main focus:",
  position: 1,
  questionable: matching_question
)

matching_pairs = [
  { term: "ISO 9001", definition: "Quality management systems", position: 1 },
  { term: "ISO/IEC 27001", definition: "Information security management", position: 2 },
  { term: "ISO/IEC 12207", definition: "Software life cycle processes", position: 3 },
  { term: "ISO/IEC 29119", definition: "Software testing processes", position: 4 },
  { term: "IEEE 829", definition: "Test documentation format", position: 5 }
]

matching_pairs.each do |pair|
  matching_question.matching_pairs.find_or_create_by!(term: pair[:term]) do |p|
    p.definition = pair[:definition]
    p.position = pair[:position]
  end
end

# Step 12: Conclusion
info_step_12 = course.steps.find_or_create_by!(
  title: "Conclusion and Key Takeaways",
  step_type: "info"
) do |step|
  step.position = 12
  step.content = ActionText::Content.new(<<-HTML
    <div class="p-4">
      <h2 class="text-2xl font-semibold mb-4">Conclusion</h2>
      <p class="mb-4">Software standards give a common ground for reliable and safe software. Organisations of any size can use them to improve teamwork, reduce risks, and earn confidence from users and clients.</p>
      <div class="grid gap-4 md:grid-cols-2 mt-4">
        <div class="border p-4">
          <h3 class="font-bold mb-2">Next Steps</h3>
          <ul class="list-disc list-inside">
            <li>Pick standards relevant to your project</li>
            <li>Check your current processes against their guidelines</li>
            <li>Plan training or audits if needed</li>
          </ul>
        </div>
        <div class="border p-4">
          <h3 class="font-bold mb-2">Ongoing Improvements</h3>
          <p>Keep updating your standards approach as your team and technology change.</p>
        </div>
      </div>
    </div>
  HTML
  )
end
