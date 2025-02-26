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
      <iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ?si=RBAJC-IkRRupMaVz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen=""></iframe>
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

# Course on Software Standards
course = Course.find_or_create_by!(
  title: "Introduction to Software Standards"
) do |c|
  c.description = "Understand the importance and implementation of software standards in engineering"
  c.image_url = "https://placehold.co/600x400?text=Software+Standards"
end

badge = course.badge || course.create_badge!(
  name: "Standards Specialist",
  description: ActionText::Content.new(<<-HTML
    <div>
      <p>Awarded for completing the Introduction to Software Standards course and demonstrating understanding of software engineering standards, their importance, and implementation.</p>
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

# Step 1: Introduction to Software Standards
info_step_1 = course.steps.find_or_create_by!(
  title: "Introduction to Software Standards",
  step_type: "info"
) do |step|
  step.position = 1
  step.content = ActionText::Content.new(<<-HTML
    <div class="standards-intro">
      <h3>What are Software Standards?</h3>
      <p>Software standards are established rules or guidelines for developing and maintaining software. They are typically set by recognized bodies such as:</p>
      <ul>
        <li><strong>ISO</strong> (International Organization for Standardization)</li>
        <li><strong>IEEE</strong> (Institute of Electrical and Electronics Engineers)</li>
      </ul>
      <p>In this course, we'll explore:</p>
      <ul>
        <li>Why these standards exist</li>
        <li>How they impact software engineering</li>
        <li>The major categories of standards in the industry</li>
        <li>How to implement standards in your organization</li>
      </ul>
    </div>

    <style>
      .standards-intro h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
    </style>
  HTML
  )
end

# Step 2: Why Do Software Standards Exist?
info_step_2 = course.steps.find_or_create_by!(
  title: "Why Do Software Standards Exist?",
  step_type: "info"
) do |step|
  step.position = 2
  step.content = ActionText::Content.new(<<-HTML
    <div class="standards-purpose">
      <h1>Why Do Software Standards Exist?</h1>
      <div class="purpose-grid">
        <div class="purpose-item">
          <h3><i class="purpose-icon">🔄</i> Consistency</h3>
          <p>Standards ensure consistent approaches to software development across teams, organizations, and countries.</p>
        </div>
        <div class="purpose-item">
          <h3><i class="purpose-icon">🛡️</i> Quality & Reliability</h3>
          <p>By following agreed-upon best practices, organizations can build software that meets safety and reliability criteria.</p>
        </div>
        <div class="purpose-item">
          <h3><i class="purpose-icon">⚠️</i> Risk Mitigation</h3>
          <p>Standards mitigate risks in projects by providing proven guidelines for processes.</p>
        </div>
        <div class="purpose-item">
          <h3><i class="purpose-icon">🗣️</i> Common Language</h3>
          <p>They serve as a unifying language for developers and companies, so everyone has clear expectations and practices.</p>
        </div>
      </div>
      <blockquote class="key-quote">
        "ISO standards help make products and systems safe, reliable, and of high quality."
        <footer>— <cite><a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank">Understanding ISO Standards for Software Engineering</a></cite></footer>
      </blockquote>
      <p>Next, we'll examine the concrete impacts these standards have on software engineering practices.</p>
    </div>

    <style>
      .standards-purpose h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .purpose-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        margin: 25px 0;
      }
      .purpose-item {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      }
      .purpose-icon {
        font-style: normal;
        font-size: 1.5em;
        margin-right: 8px;
        vertical-align: middle;
      }
      .key-quote {
        background-color: #e8f6f3;
        padding: 20px;
        border-left: 5px solid #1abc9c;
        margin: 25px 0;
        font-style: italic;
      }
      .key-quote footer {
        text-align: right;
        margin-top: 10px;
        font-size: 0.9em;
      }
      .key-quote a {
        color: #16a085;
        text-decoration: none;
      }
      .key-quote a:hover {
        text-decoration: underline;
      }
      @media (max-width: 768px) {
        .purpose-grid {
          grid-template-columns: 1fr;
        }
      }
    </style>
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
    <div class="standards-impact">
      <h1>Impact on Software Engineering</h1>
      <p>Adopting software standards has a significant positive impact on software engineering practices and outcomes. Let's examine these impacts:</p>
      <div class="impact-cards">
        <div class="impact-card">
          <div class="card-header quality">
            <h3>Improved Quality</h3>
          </div>
          <div class="card-body">
            <p>Standards improve software quality and reliability by enforcing rigorous development and testing practices.</p>
            <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank" class="source-link">Source: Institute of Data</a>
          </div>
        </div>
        <div class="impact-card">
          <div class="card-header structure">
            <h3>Structured Approach</h3>
          </div>
          <div class="card-body">
            <p>Standards provide a structured approach to development, which helps teams identify and fix issues early in the process.</p>
            <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank" class="source-link">Source: Institute of Data</a>
          </div>
        </div>
        <div class="impact-card">
          <div class="card-header trust">
            <h3>Increased Trust</h3>
          </div>
          <div class="card-body">
            <p>Organizations that adhere to well-known standards demonstrate a commitment to quality, increasing customer trust in their products.</p>
            <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank" class="source-link">Source: Institute of Data</a>
          </div>
        </div>
        <div class="impact-card">
          <div class="card-header collab">
            <h3>Enhanced Collaboration</h3>
          </div>
          <div class="card-body">
            <p>Teams across different companies or countries can work together more easily because they follow the same established practices.</p>
            <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank" class="source-link">Source: Institute of Data</a>
          </div>
        </div>
      </div>
      <div class="impact-diagram">
        <h3>How Standards Flow Through Software Development:</h3>
        <div class="flow-diagram">
          <div class="flow-item">Requirements</div>
          <div class="flow-arrow">→</div>
          <div class="flow-item">Design</div>
          <div class="flow-arrow">→</div>
          <div class="flow-item">Implementation</div>
          <div class="flow-arrow">→</div>
          <div class="flow-item">Testing</div>
          <div class="flow-arrow">→</div>
          <div class="flow-item">Maintenance</div>
        </div>
        <p class="diagram-caption">Standards influence every phase of the software development lifecycle</p>
      </div>
    </div>

    <style>
      .standards-impact h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .impact-cards {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        margin: 25px 0;
      }
      .impact-card {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
      }
      .card-header {
        padding: 15px;
        color: white;
      }
      .card-header h3 {
        margin: 0;
      }
      .card-header.quality {
        background-color: #3498db;
      }
      .card-header.structure {
        background-color: #9b59b6;
      }
      .card-header.trust {
        background-color: #2ecc71;
      }
      .card-header.collab {
        background-color: #e74c3c;
      }
      .card-body {
        padding: 15px;
        background-color: white;
      }
      .source-link {
        display: block;
        margin-top: 10px;
        font-size: 0.8em;
        color: #7f8c8d;
        text-decoration: none;
      }
      .source-link:hover {
        color: #3498db;
        text-decoration: underline;
      }
      .impact-diagram {
        margin: 30px 0;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
      }
      .flow-diagram {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        margin: 20px 0;
      }
      .flow-item {
        background-color: #3498db;
        color: white;
        padding: 10px 15px;
        border-radius: 5px;
        font-weight: bold;
      }
      .flow-arrow {
        color: #7f8c8d;
        font-weight: bold;
        font-size: 1.2em;
      }
      .diagram-caption {
        text-align: center;
        color: #7f8c8d;
        font-style: italic;
      }
      @media (max-width: 768px) {
        .impact-cards {
          grid-template-columns: 1fr;
        }
        .flow-diagram {
          flex-direction: column;
          gap: 10px;
        }
        .flow-arrow {
          transform: rotate(90deg);
        }
      }
    </style>
  HTML
  )
end

# Step 4: International Organization for Standardization (ISO)
info_step_4 = course.steps.find_or_create_by!(
  title: "International Organization for Standardization (ISO)",
  step_type: "info"
) do |step|
  step.position = 4
  step.content = ActionText::Content.new(<<-HTML
    <div class="iso-standards">
      <h1>International Organization for Standardization (ISO)</h1>
      <div class="org-profile">
        <div class="org-logo">
          <p><a href="https://commons.wikimedia.org/wiki/File:ISO_Logo_(Red_square).svg#/media/File:ISO_Logo_(Red_square).svg"><img src="https://upload.wikimedia.org/wikipedia/commons/e/e3/ISO_Logo_%28Red_square%29.svg" alt="ISO Logo (Red square).svg" height="480" width="521"></a></p>
        </div>
        <div class="org-info">
          <h3>ISO at a Glance</h3>
          <br>
          <ul>
            <li><strong>Founded:</strong> 1947</li>
            <li><strong>Headquarters:</strong> Geneva, Switzerland</li>
            <li><strong>Members:</strong> Standards bodies from 165 countries</li>
            <li><strong>Standards published:</strong> Over 24,000</li>
            <li><strong>Structure:</strong> One member per country</li>
          </ul>
        </div>
      </div>
      <div class="iso-description">
        <p>The ISO is a global, independent organization that publishes a wide range of international standards. ISO standards span many industries (from software to food production), and their primary goal is to help organizations improve their processes and services by following a set of agreed norms.</p>
        <blockquote class="standard-quote">
          "These standards are a list of technical requirements that aims to maximize the product's quality, safety, and efficiency. They are a set of standardized tests, terms, definitions, and procedures that software companies need to comply with."
          <footer>— <cite><a href="https://www.softkraft.co/software-development-standards/" target="_blank">Software Development Standards: ISO compliance and Agile</a></cite></footer>
        </blockquote>
      </div>
      <div class="key-iso-standards">
        <h3>Key ISO Standards for Software Engineering</h3>
        <div class="standards-table">
          <table>
            <thead>
              <tr>
                <th>Standard</th>
                <th>Focus Area</th>
                <th>Description</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>ISO 9001</td>
                <td>Quality Management</td>
                <td>General standard for quality management systems across industries</td>
              </tr>
              <tr>
                <td>ISO/IEC 12207</td>
                <td>Software Lifecycle</td>
                <td>Framework for software lifecycle processes from conception through retirement</td>
              </tr>
              <tr>
                <td>ISO/IEC 25010</td>
                <td>Software Quality</td>
                <td>Quality model for software products and computer systems</td>
              </tr>
              <tr>
                <td>ISO/IEC 27001</td>
                <td>Security</td>
                <td>Framework for information security management systems</td>
              </tr>
              <tr>
                <td>ISO/IEC 29119</td>
                <td>Software Testing</td>
                <td>Standards for software testing processes, techniques, and documentation</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="iso-iec-note">
        <h4><strong>Note on ISO/IEC Standards</strong></h4>
        <p>ISO often works with the IEC (International Electrotechnical Commission) on technology standards, which is why many are joint ISO/IEC standards.</p>
        <a href="https://mitc.center/blog/news/what-is-iso-iec-ieee-29119-and-how-is-it-used-in-the-mitc-exam" target="_blank" class="reference-link">Learn more about ISO/IEC collaboration</a>
      </div>
      <div class="benefits-box">
        <h3>Benefits of Implementing ISO Standards</h3>
        <ul>
          <li>Internationally recognized best practices</li>
          <li>Improved consistency across organizations</li>
          <li>Enhanced market reputation</li>
          <li>Reduced errors and risks</li>
          <li>Easier collaboration with international partners</li>
        </ul>
      </div>
    </div>

    <style>
      .iso-standards h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .org-profile {
        display: flex;
        gap: 20px;
        margin: 25px 0;
        flex-wrap: wrap;
      }
      .org-logo {
        flex: 0 0 300px;
      }
      .org-info {
        flex: 1;
        min-width: 300px;
      }
      .iso-description {
        margin: 25px 0;
      }
      .standard-quote {
        background-color: #f4f6f7;
        padding: 20px;
        border-left: 5px solid #95a5a6;
        margin: 25px 0;
        font-style: italic;
      }
      .standard-quote footer {
        text-align: right;
        margin-top: 10px;
        font-size: 0.9em;
      }
      .key-iso-standards {
        margin: 30px 0;
      }
      .standards-table {
        overflow-x: auto;
      }
      .standards-table table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }
      .standards-table th, .standards-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
      }
      .standards-table thead {
        background-color: #3498db;
        color: white;
      }
      .standards-table tr:nth-child(even) {
        background-color: #f2f2f2;
      }
      .iso-iec-note {
        background-color: #e8f4fd;
        border-radius: 8px;
        padding: 15px;
        margin: 25px 0;
      }
      .reference-link {
        display: inline-block;
        margin-top: 10px;
        color: #3498db;
        text-decoration: none;
      }
      .reference-link:hover {
        text-decoration: underline;
      }
      .benefits-box {
        background-color: #eafaf1;
        border: 1px solid #2ecc71;
        border-radius: 8px;
        padding: 15px;
        margin: 25px 0;
      }
      .benefits-box h3 {
        color: #27ae60;
        margin-top: 0;
      }
    </style>
  HTML
  )
end

# Step 5: Institute of Electrical and Electronics Engineers (IEEE)
info_step_5 = course.steps.find_or_create_by!(
  title: "Institute of Electrical and Electronics Engineers (IEEE)",
  step_type: "info"
) do |step|
  step.position = 5
  step.content = ActionText::Content.new(<<-HTML
    <div class="ieee-standards">
      <h1>Institute of Electrical and Electronics Engineers (IEEE)</h1>
      <div class="org-profile">
        <div class="org-logo">
          <p><a href="https://commons.wikimedia.org/wiki/File:IEEE_logo.svg#/media/File:IEEE_logo.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/2/21/IEEE_logo.svg" alt="IEEE logo.svg" height="131" width="233"></a></p>
        </div>
        <div class="org-info">
          <h3>IEEE at a Glance</h3>
          <br>
          <ul>
            <li><strong>Founded:</strong> 1963 (merged from earlier organizations dating back to 1884)</li>
            <li><strong>Headquarters:</strong> New York, USA</li>
            <li><strong>Members:</strong> Over 400,000 professionals worldwide</li>
            <li><strong>Structure:</strong> Professional association (membership-based)</li>
            <li><strong>Activities:</strong> Standards development, publishing, conferences, education</li>
          </ul>
        </div>
      </div>
      <div class="ieee-description">
        <p>The IEEE is a professional association known for advancing technology and setting technical standards. Through its Standards Association, IEEE has introduced numerous software engineering standards that help define good practices for developing and maintaining software.</p>
        <div class="comparison-box">
          <h3>IEEE vs. ISO: Understanding the Difference</h3>
          <table class="comparison-table">
            <thead>
              <tr>
                <th>Aspect</th>
                <th>IEEE</th>
                <th>ISO</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Type of Organization</td>
                <td>Professional association</td>
                <td>Treaty-based standards organization</td>
              </tr>
              <tr>
                <td>Membership</td>
                <td>Individual professionals</td>
                <td>National standards bodies (one per country)</td>
              </tr>
              <tr>
                <td>Focus</td>
                <td>Electrical, electronic, computing technologies</td>
                <td>All industries and sectors</td>
              </tr>
              <tr>
                <td>Approach</td>
                <td>More technically detailed standards</td>
                <td>Broader process and system standards</td>
              </tr>
            </tbody>
          </table>
          <p class="note">Both organizations are highly respected and often collaborate on standards development.</p>
        </div>
      </div>
      <div class="key-ieee-standards">
        <h3>Key IEEE Software Engineering Standards</h3>
        <div class="standards-cards">
          <div class="standard-card">
            <div class="standard-number">IEEE 730</div>
            <div class="standard-title">Software Quality Assurance</div>
            <div class="standard-desc">Outlines requirements for initiating, planning, controlling, and executing Software Quality Assurance processes.</div>
          </div>
          <div class="standard-card">
            <div class="standard-number">IEEE 829</div>
            <div class="standard-title">Test Documentation</div>
            <div class="standard-desc">Specifies the form and content of a complete software test documentation suite.</div>
          </div>
          <div class="standard-card">
            <div class="standard-number">IEEE 1012</div>
            <div class="standard-title">Verification and Validation</div>
            <div class="standard-desc">Establishes requirements for verification and validation processes throughout the software lifecycle.</div>
          </div>
          <div class="standard-card">
            <div class="standard-number">IEEE 1028</div>
            <div class="standard-title">Reviews and Audits</div>
            <div class="standard-desc">Provides requirements for systematic reviews, inspections, and audits of software.</div>
          </div>
          <div class="standard-card">
            <div class="standard-number">IEEE 1061</div>
            <div class="standard-title">Software Quality Metrics</div>
            <div class="standard-desc">Provides a methodology for establishing quality requirements and identifying, implementing, and validating quality metrics.</div>
          </div>
        </div>
        <p class="source-citation">Source: <a href="https://www.institutedata.com/us/blog/standards-and-guidelines-in-software-engineering/" target="_blank">Understanding Standards and Guidelines in Software Engineering</a></p>
      </div>
      <div class="impact-quote">
        <blockquote>
          "IEEE standards, like ISO's, aim to improve software quality and consistency. While ISO is an international treaty-based organization, IEEE is a global professional body; both contribute significantly to establishing consensus-based guidelines that engineers around the world follow."
        </blockquote>
      </div>
    </div>

    <style>
      .ieee-standards h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .org-profile {
        display: flex;
        gap: 20px;
        margin: 25px 0;
        flex-wrap: wrap;
      }
      .org-logo {
        flex: 0 0 300px;
      }
      .org-info {
        flex: 1;
        min-width: 300px;
      }
      .ieee-description {
        margin: 25px 0;
      }
      .comparison-box {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 15px;
        margin: 25px 0;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      }
      .comparison-table {
        width: 100%;
        border-collapse: collapse;
        margin: 15px 0;
      }
      .comparison-table th, .comparison-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
      }
      .comparison-table thead {
        background-color: #9b59b6;
        color: white;
      }
      .comparison-table tr:nth-child(even) {
        background-color: #f2f2f2;
      }
      .note {
        font-style: italic;
        color: #7f8c8d;
        margin-top: 15px;
      }
      .standards-cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin: 20px 0;
      }
      .standard-card {
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
      }
      .standard-card:hover {
        transform: translateY(-5px);
      }
      .standard-number {
        background-color: #3498db;
        color: white;
        padding: 10px;
        font-weight: bold;
        font-size: 1.1em;
      }
      .standard-title {
        padding: 10px;
        background-color: #f5f6fa;
        font-weight: bold;
        border-bottom: 1px solid #eee;
      }
      .standard-desc {
        padding: 15px;
      }
      .source-citation {
        text-align: right;
        font-size: 0.9em;
        color: #7f8c8d;
      }
      .source-citation a {
        color: #3498db;
        text-decoration: none;
      }
      .impact-quote {
        background-color: #ebf5fb;
        border-left: 5px solid #3498db;
        padding: 15px 20px;
        margin: 30px 0;
      }
      .impact-quote blockquote {
        margin: 0;
        font-style: italic;
        color: #34495e;
      }
    </style>
  HTML
  )
end

# Step 6: Major Categories of Software Standards
info_step_6 = course.steps.find_or_create_by!(
  title: "Major Categories of Software Standards",
  step_type: "info"
) do |step|
  step.position = 6
  step.content = ActionText::Content.new(<<-HTML
    <div class="standards-categories">
      <h1>Major Categories of Software Standards</h1>
      <p>Software standards can be grouped into several key categories, each addressing different aspects of the software development and maintenance process:</p>
      <div class="categories-container">
        <div class="category-item process-standards">
          <div class="category-icon">📋</div>
          <h3>Process Standards</h3>
          <div class="category-content">
            <p>Define how to carry out software development or maintenance processes.</p>
            <div class="example-standard">
              <h4>Example: ISO/IEC 12207</h4>
              <p>Provides a comprehensive framework for the software life cycle processes from conception through retirement.</p>
              <a href="https://www.softkraft.co/software-development-standards/" target="_blank">Learn more about ISO/IEC 12207</a>
            </div>
          </div>
        </div>
        <div class="category-item quality-standards">
          <div class="category-icon">🔍</div>
          <h3>Quality Management Standards</h3>
          <div class="category-content">
            <p>Focus on organizational processes to ensure quality products.</p>
            <div class="example-standard">
              <h4>Example: ISO 9001</h4>
              <p>Sets the framework for implementing a quality management system (QMS) in an organization.</p>
              <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank">Learn more about ISO 9001</a>
            </div>
          </div>
        </div>
        <div class="category-item security-standards">
          <div class="category-icon">🔒</div>
          <h3>Security Standards</h3>
          <div class="category-content">
            <p>Ensure that software and data are protected.</p>
            <div class="example-standard">
              <h4>Example: ISO/IEC 27001</h4>
              <p>Provides a systematic approach to information security management.</p>
              <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank">Learn more about ISO/IEC 27001</a>
            </div>
          </div>
        </div>
        <div class="category-item testing-standards">
          <div class="category-icon">✅</div>
          <h3>Testing Standards</h3>
          <div class="category-content">
            <p>Provide guidelines for testing processes and documentation.</p>
            <div class="example-standard">
              <h4>Example: ISO/IEC/IEEE 29119</h4>
              <p>A set of standards for software testing processes, techniques, and documentation.</p>
              <a href="https://mitc.center/blog/news/what-is-iso-iec-ieee-29119-and-how-is-it-used-in-the-mitc-exam" target="_blank">Learn more about ISO/IEC/IEEE 29119</a>
            </div>
          </div>
        </div>
        <div class="category-item documentation-standards">
          <div class="category-icon">📝</div>
          <h3>Documentation and Coding Standards</h3>
          <div class="category-content">
            <p>Specify formats and practices for documentation or code style.</p>
            <div class="example-standard">
              <h4>Example: IEEE 829</h4>
              <p>Prescribes how to write test documentation (test plans, cases, reports) for consistency and thoroughness.</p>
              <a href="https://www.qodo.ai/glossary/ieee-829/" target="_blank">Learn more about IEEE 829</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <style>
      .standards-categories h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .categories-container {
        display: flex;
        flex-direction: column;
        gap: 25px;
        margin: 30px 0;
      }
      .category-item {
        display: flex;
        gap: 15px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
      }
      .category-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2em;
        padding: 0 20px;
        color: white;
      }
      .process-standards .category-icon {
        background-color: #3498db;
      }
      .quality-standards .category-icon {
        background-color: #9b59b6;
      }
      .security-standards .category-icon {
        background-color: #e74c3c;
      }
      .testing-standards .category-icon {
        background-color: #2ecc71;
      }
      .documentation-standards .category-icon {
        background-color: #f39c12;
      }
      .category-content {
        padding: 15px;
        flex: 1;
      }
      .example-standard {
        background-color: #f8f9fa;
        border-radius: 5px;
        padding: 10px 15px;
        margin-top: 10px;
      }
      .example-standard h4 {
        margin: 0 0 5px 0;
        color: #2c3e50;
      }
      .example-standard a {
        display: inline-block;
        margin-top: 5px;
        color: #3498db;
        text-decoration: none;
        font-size: 0.9em;
      }
      .example-standard a:hover {
        text-decoration: underline;
      }
    </style>
  HTML
  )
end

# Step 7: Misconception - "Standards Stifle Innovation" (True/False)
tf_step = course.steps.find_or_create_by!(
  title: "Standards and Innovation",
  step_type: "question"
) do |step|
  step.position = 7
end

tf_question = tf_step.questions.find_or_create_by!(
  prompt: "\"Software standards stifle innovation by forcing developers to do everything the same way.\"",
  position: 1
) do |q|
  q.questionable = TrueFalseQuestion.find_or_create_by!(
    correct_answer: false,
    success_message: "✓ Excellent! You're right. Standards provide guidelines for quality and consistency, but they do not dictate creative design decisions. Rather than hindering creativity, standards ensure that basic good practices are in place (like documentation and testing), creating a solid foundation on which innovation can thrive.",
    failure_message: "That's not quite right. Standards don't actually restrict innovation - they provide a framework of best practices that ensures quality and safety, while still allowing plenty of room for creative problem-solving. Think of standards as the foundation that makes innovation more effective and reliable."
  )
end

# Step 8: Knowledge Check - Benefits of Standards (Multiple Choice)
mc_step = course.steps.find_or_create_by!(
  title: "Benefits of Standards",
  step_type: "question"
) do |step|
  step.position = 8
end

mc_question = mc_step.questions.find_or_create_by!(
  prompt: "Which of the following is a genuine benefit of following software engineering standards?",
  position: 1
) do |q|
  q.questionable = MultipleChoiceQuestion.find_or_create_by!(
    allow_multiple_answers: false,
    success_message: "✓ Correct! Standards help improve software quality and reliability by establishing best practices and consistent approaches to development.",
    failure_message: "That's not the right answer. Think about what standards are designed to accomplish in terms of quality and consistency."
  )
end

# Add multiple choice options
options = [
  { text: "It completely eliminates the need for testing.", correct: false, feedback: "Standards actually emphasize the importance of testing, not eliminate it. Many standards like ISO/IEC 29119 are specifically about how to conduct effective testing." },
  { text: "It improves software quality and reliability.", correct: true, feedback: "Yes! This is one of the primary benefits of following standards. They help ensure consistent quality through proven practices." },
  { text: "It guarantees a project's success without good management.", correct: false, feedback: "Standards are helpful, but they don't replace the need for good project management. Both are necessary for successful software projects." },
  { text: "It makes development processes chaotic and unpredictable.", correct: false, feedback: "The opposite is true! Standards bring consistency and predictability to development processes." }
]

options.each do |option|
  mc_question.questionable.options.find_or_create_by!(text: option[:text]) do |o|
    o.correct = option[:correct]
    o.feedback = option[:feedback]
  end
end

# Step 9: Implementing and Complying with Standards
info_step_9 = course.steps.find_or_create_by!(
  title: "Implementing and Complying with Standards",
  step_type: "info"
) do |step|
  step.position = 9
  step.content = ActionText::Content.new(<<-HTML
    <div class="implementing-standards">
      <h1>Implementing and Complying with Standards</h1>
      <div class="implementation-phases">
        <div class="phase-container">
          <div class="phase phase-1">
            <h3>Phase 1: Assessment</h3>
            <div class="phase-details">
              <ul>
                <li>Evaluate current practices</li>
                <li>Identify gaps between existing processes and standard requirements</li>
                <li>Select relevant standards for your organization</li>
                <li>Analyze cost and resource requirements</li>
              </ul>
            </div>
          </div>
          <div class="phase-arrow">→</div>
          <div class="phase phase-2">
            <h3>Phase 2: Planning</h3>
            <div class="phase-details">
              <ul>
                <li>Create implementation roadmap</li>
                <li>Develop documentation templates</li>
                <li>Allocate resources and responsibilities</li>
                <li>Set realistic timelines</li>
              </ul>
            </div>
          </div>
          <div class="phase-arrow">→</div>
          <div class="phase phase-3">
            <h3>Phase 3: Implementation</h3>
            <div class="phase-details">
              <ul>
                <li>Train team members</li>
                <li>Update processes and documentation</li>
                <li>Apply standards to pilot projects</li>
                <li>Gather feedback and make adjustments</li>
              </ul>
            </div>
          </div>
          <div class="phase-arrow">→</div>
          <div class="phase phase-4">
            <h3>Phase 4: Verification</h3>
            <div class="phase-details">
              <ul>
                <li>Conduct internal audits</li>
                <li>Prepare for external certification (if needed)</li>
                <li>Measure compliance and effectiveness</li>
                <li>Address non-conformities</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="certification-process">
        <h3>The Certification Process</h3>
        <p>For organizations seeking official certification in standards like ISO 9001 or ISO/IEC 27001, the process typically includes:</p>
        <div class="cert-steps">
          <div class="cert-step">
            <div class="step-number">1</div>
            <div class="step-content">
              <h4>Preparation</h4>
              <p>Document processes, train employees, and ensure practices align with the standard.</p>
            </div>
          </div>
          <div class="cert-step">
            <div class="step-number">2</div>
            <div class="step-content">
              <h4>Stage 1 Audit</h4>
              <p>External auditors review documentation to verify basic compliance with the standard.</p>
            </div>
          </div>
          <div class="cert-step">
            <div class="step-number">3</div>
            <div class="step-content">
              <h4>Stage 2 Audit</h4>
              <p>Auditors assess actual implementation of the standard in practice.</p>
            </div>
          </div>
          <div class="cert-step">
            <div class="step-number">4</div>
            <div class="step-content">
              <h4>Certification</h4>
              <p>If successful, organization receives certification, typically valid for 3 years.</p>
            </div>
          </div>
          <div class="cert-step">
            <div class="step-number">5</div>
            <div class="step-content">
              <h4>Surveillance</h4>
              <p>Regular check-ups (usually annual) ensure continued compliance.</p>
            </div>
          </div>
        </div>
        <div class="cert-quote">
          <p>"Obtaining ISO certification is a systematic process that requires organizational commitment, thorough documentation, and a willingness to undergo external scrutiny to validate their adherence to international standards."</p>
          <p class="quote-source">— <a href="https://www.institutedata.com/us/blog/iso-standards-for-software-engineering/" target="_blank">Understanding ISO Standards for Software Engineering</a></p>
        </div>
      </div>
      <div class="implementation-tips">
        <h3>Tips for Successful Implementation</h3>
        <div class="tips-columns">
          <div class="tips-column">
            <div class="tip">
              <h4>Start Small</h4>
              <p>Begin with a pilot project or department before rolling out across the organization.</p>
            </div>
            <div class="tip">
              <h4>Focus on Value</h4>
              <p>Implement standards in a way that adds genuine value, not just bureaucracy.</p>
            </div>
            <div class="tip">
              <h4>Get Leadership Support</h4>
              <p>Ensure management is committed to the standards adoption process.</p>
            </div>
          </div>
          <div class="tips-column">
            <div class="tip">
              <h4>Involve the Team</h4>
              <p>Get input from those who will be following the standards in their daily work.</p>
            </div>
            <div class="tip">
              <h4>Document Clearly</h4>
              <p>Create clear, accessible documentation that helps rather than hinders.</p>
            </div>
            <div class="tip">
              <h4>Continuous Improvement</h4>
              <p>Regularly review and refine your implementation of standards.</p>
            </div>
          </div>
        </div>
      </div>
      <div class="voluntary-vs-required">
        <h3>Voluntary vs. Required Compliance</h3>
        <div class="compliance-table-container">
          <table class="compliance-table">
            <thead>
              <tr>
                <th>Voluntary Compliance</th>
                <th>Required Compliance</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Organization chooses to follow standards to improve quality and processes</td>
                <td>Industry regulations or client contracts mandate compliance with specific standards</td>
              </tr>
              <tr>
                <td>Can be implemented gradually</td>
                <td>Often has strict deadlines for implementation</td>
              </tr>
              <tr>
                <td>Flexibility to adapt standards to organizational needs</td>
                <td>Usually requires strict adherence to specified standards</td>
              </tr>
              <tr>
                <td>Examples: Adopting coding standards for internal quality</td>
                <td>Examples: Medical device software (IEC 62304), Financial systems (PCI DSS)</td>
              </tr>
            </tbody>
          </table>
        </div>
        <p>Whether voluntary or required, successful implementation means integrating the standard's practices into your day-to-day workflow in a way that adds value rather than bureaucracy.</p>
      </div>
    </div>

    <style>
      .implementing-standards h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .implementation-phases {
        margin: 30px 0;
      }
      .phase-container {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: stretch;
      }
      .phase {
        flex: 1;
        min-width: 200px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        overflow: hidden;
      }
      .phase h3 {
        margin: 0;
        padding: 15px;
        color: white;
      }
      .phase-details {
        padding: 15px;
      }
      .phase-1 h3 {
        background-color: #3498db;
      }
      .phase-2 h3 {
        background-color: #2ecc71;
      }
      .phase-3 h3 {
        background-color: #e74c3c;
      }
      .phase-4 h3 {
        background-color: #9b59b6;
      }
      .phase-arrow {
        display: flex;
        align-items: center;
        color: #7f8c8d;
        font-size: 1.5em;
      }
      .certification-process {
        margin: 40px 0;
        padding: 25px;
        background-color: #f9f9f9;
        border-radius: 10px;
      }
      .cert-steps {
        margin: 25px 0;
      }
      .cert-step {
        display: flex;
        margin-bottom: 15px;
      }
      .step-number {
        background-color: #3498db;
        color: white;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        margin-right: 15px;
      }
      .step-content h4 {
        margin: 0 0 5px 0;
        color: #2c3e50;
      }
      .step-content p {
        margin: 0;
      }
      .cert-quote {
        background-color: #e8f4f8;
        border-radius: 8px;
        padding: 15px 20px;
        margin: 25px 0 0 0;
        font-style: italic;
      }
      .quote-source {
        text-align: right;
        margin: 10px 0 0 0;
        font-size: 0.9em;
      }
      .quote-source a {
        color: #3498db;
        text-decoration: none;
      }
      .implementation-tips {
        margin: 40px 0;
      }
      .tips-columns {
        display: flex;
        gap: 20px;
        margin: 20px 0;
        flex-wrap: wrap;
      }
      .tips-column {
        flex: 1;
        min-width: 300px;
      }
      .tip {
        background-color: #f8f9fa;
        border-left: 3px solid #3498db;
        padding: 15px;
        margin-bottom: 15px;
        border-radius: 0 5px 5px 0;
      }
      .tip h4 {
        margin: 0 0 8px 0;
        color: #3498db;
      }
      .tip p {
        margin: 0;
      }
      .voluntary-vs-required {
        margin: 40px 0;
      }
      .compliance-table-container {
        overflow-x: auto;
      }
      .compliance-table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }
      .compliance-table th, .compliance-table td {
        border: 1px solid #ddd;
        padding: 12px;
      }
      .compliance-table th {
        background-color: #34495e;
        color: white;
        text-align: center;
      }
      .compliance-table tr:nth-child(even) {
        background-color: #f2f2f2;
      }
      @media (max-width: 768px) {
        .phase-container {
          flex-direction: column;
        }
        .phase-arrow {
          transform: rotate(90deg);
          margin: 10px auto;
        }
      }
    </style>
  HTML
  )
end

# Step 10: Misconception - "Only Big or Regulated Companies Need Standards" (True/False)
tf_step_2 = course.steps.find_or_create_by!(
  title: "Standards for All Companies",
  step_type: "question"
) do |step|
  step.position = 10
end

tf_question_2 = tf_step_2.questions.find_or_create_by!(
  prompt: "\"Software standards are only necessary for large companies or strictly regulated industries. Smaller teams or general projects don't benefit from them.\"",
  position: 1
) do |q|
  q.questionable = TrueFalseQuestion.find_or_create_by!(
    correct_answer: false,
    success_message: "✓ Correct! Companies and projects of all sizes can benefit from implementing software standards. Even a small development team can improve efficiency and product quality by following well-established practices. Standards scale to different contexts and can help prevent problems in projects of any scope.",
    failure_message: "That's not correct. Software standards aren't just for large or regulated organizations. Standards provide value regardless of company size or project type. Even small teams can benefit from the structure, consistency, and quality that standards bring to software development."
  )
end

# Step 11: Matching Exercise - Connect Standards to Descriptions
matching_step = course.steps.find_or_create_by!(
  title: "Match Standards to Descriptions",
  step_type: "question"
) do |step|
  step.position = 11
end

matching_question = MatchingQuestion.find_or_create_by!(
  matching_style: "drawing",
  success_message: "✓ Excellent work! You've correctly matched each standard with its description. This shows a good understanding of the different types of standards and their specific purposes in software engineering.",
  failure_message: "Some of your matches aren't correct. Review the descriptions carefully and try again, thinking about what each standard is primarily focused on."
)

matching_step.questions.find_or_create_by!(
  prompt: "Match each software standard to its primary focus:",
  position: 1,
  questionable: matching_question
)

matching_pairs = [
  { term: "ISO 9001", definition: "Standard for quality management systems, outlining how organizations can consistently meet customer quality requirements", position: 1 },
  { term: "ISO/IEC 27001", definition: "Standard for information security management, detailing a framework to protect data and manage security risks", position: 2 },
  { term: "ISO/IEC 12207", definition: "Standard for software life cycle processes, covering activities from system conception through retirement of software", position: 3 },
  { term: "ISO/IEC 29119", definition: "Standard for software testing processes, providing internationally agreed practices for test management and design", position: 4 },
  { term: "IEEE 829", definition: "Standard for software test documentation, specifying formats and contents of test plans, test cases, and reports", position: 5 }
]

matching_pairs.each do |pair|
  matching_question.matching_pairs.find_or_create_by!(term: pair[:term]) do |p|
    p.definition = pair[:definition]
    p.position = pair[:position]
  end
end

# Step 12: Conclusion and Key Takeaways
info_step_12 = course.steps.find_or_create_by!(
  title: "Conclusion and Key Takeaways",
  step_type: "info"
) do |step|
  step.position = 12
  step.content = ActionText::Content.new(<<-HTML
    <div class="standards-conclusion">
      <h1>Conclusion and Key Takeaways</h1>
      <div class="conclusion-banner">
        <div class="banner-content">
          <h2>Software Standards: The Foundation of Quality Engineering</h2>
        </div>
      </div>
      <div class="key-takeaways">
        <h3>What We've Learned</h3>
        <div class="takeaways-grid">
          <div class="takeaway-item">
            <div class="takeaway-icon">🌐</div>
            <div class="takeaway-content">
              <h4>Standards Organizations</h4>
              <p>Organizations like ISO and IEEE establish frameworks that improve consistency, reduce errors, and facilitate global collaboration.</p>
            </div>
          </div>
          <div class="takeaway-item">
            <div class="takeaway-icon">📊</div>
            <div class="takeaway-content">
              <h4>Types of Standards</h4>
              <p>Different categories of standards address processes, quality, security, testing, and documentation to create comprehensive quality management.</p>
            </div>
          </div>
          <div class="takeaway-item">
            <div class="takeaway-icon">🔄</div>
            <div class="takeaway-content">
              <h4>Implementation</h4>
              <p>Successful implementation involves assessment, planning, training, and continuous improvement to make standards work for your organization.</p>
            </div>
          </div>
          <div class="takeaway-item">
            <div class="takeaway-icon">📈</div>
            <div class="takeaway-content">
              <h4>Benefits</h4>
              <p>Standards improve quality, enhance trust, facilitate collaboration, and create a foundation for systematic software engineering.</p>
            </div>
          </div>
        </div>
      </div>
      <div class="final-thoughts">
        <p>Software standards form the backbone of best practices in software engineering. They exist to ensure that regardless of who develops a software system, certain quality and process benchmarks are met.</p>
        <p>We've seen that standards like those from ISO and IEEE provide frameworks that improve consistency, reduce errors, and facilitate collaboration across teams and borders. We've also learned that there are different types of standards for processes, quality, security, testing, and documentation, and they are beneficial to organizations of all sizes.</p>
        <p>By understanding and applying the right standards, software engineers can build better software – software that is safer, more reliable, and easier to maintain. Embracing standards is ultimately about striving for excellence and trust in software development.</p>
      </div>
      <div class="next-steps">
        <h3>Where to Go From Here</h3>
        <div class="steps-container">
          <div class="next-step">
            <h4>Explore Specific Standards</h4>
            <p>Identify which standards are most relevant to your organization and study them in depth.</p>
          </div>
          <div class="next-step">
            <h4>Assess Your Current Processes</h4>
            <p>Evaluate how your existing practices compare to standard recommendations.</p>
          </div>
          <div class="next-step">
            <h4>Create an Implementation Plan</h4>
            <p>Develop a strategy for adopting standards in a way that adds value to your organization.</p>
          </div>
          <div class="next-step">
            <h4>Join Communities</h4>
            <p>Connect with others implementing standards through professional groups and online forums.</p>
          </div>
        </div>
      </div>
    </div>

    <style>
      .standards-conclusion h1 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
      }
      .conclusion-banner {
        height: 200px;
        background: linear-gradient(135deg, #3498db, #9b59b6);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 30px 0;
        color: white;
        text-align: center;
        padding: 0 20px;
      }
      .banner-content h2 {
        margin: 0;
        font-size: 2em;
        text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
      }
      .key-takeaways {
        margin: 40px 0;
      }
      .takeaways-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin: 25px 0;
      }
      .takeaway-item {
        display: flex;
        gap: 15px;
        background-color: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        border-top: 4px solid #3498db;
      }
      .takeaway-icon {
        font-size: 2em;
      }
      .takeaway-content h4 {
        margin: 0 0 10px 0;
        color: #3498db;
      }
      .takeaway-content p {
        margin: 0;
        color: #34495e;
      }
      .final-thoughts {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 25px;
        margin: 30px 0;
        line-height: 1.6;
        color: #2c3e50;
      }
      .next-steps {
        margin: 40px 0;
      }
      .steps-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        margin: 25px 0;
      }
      .next-step {
        background-color: #e8f4f8;
        border-radius: 8px;
        padding: 20px;
        border-left: 4px solid #2980b9;
      }
      .next-step h4 {
        color: #2980b9;
        margin: 0 0 10px 0;
      }
      .next-step p {
        margin: 0;
        color: #34495e;
      }
    </style>
  HTML
  )
end
