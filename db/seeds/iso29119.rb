require_relative 'helpers/course_helper'
include CourseHelper

course = Course.find_or_create_by!(
  title: "ISO 29119-3 - The Test Plan"
) do |c|
  c.description = "This beginner-friendly course on ISO 29119-3 and test planning combines information with interactive Q&A, guiding you through key concepts, test plan components, and real-world applications with explanations and practice questions."
  c.image_url = "https://i.imgur.com/IBtk946.png"
end

badge_description = <<-HTML
  <div>
    <p>Awarded for completing the Introduction to ISO 29119 course and demonstrating an understanding of software testing standards, including test planning, design, and execution principles outlined in ISO 29119.</p>
  </div>
HTML
create_badge(course, "Standards Specialist", badge_description, "app/assets/images/iso-29119-badge.png")


intro_content = <<-HTML
<div class="max-w-3xl mx-auto leading-relaxed">
  <p class="mb-5">ISO 29119 is a family of international standards for software testing. Part 3 of this series (ISO/IEC/IEEE 29119-3) focuses on <strong>test documentation</strong>, which includes test plans, test cases, and other artifacts used in testing.</p>
  <p class="mb-5">The goal of ISO 29119-3 is to provide a consistent, industry-approved structure for planning and documenting tests, ensuring clarity and alignment in any project. Importantly, ISO 29119-3 is <strong>methodology-agnostic</strong> – it can be applied to traditional Waterfall projects, iterative models, Agile teams, or any other software development lifecycle.</p>
  <p class="mb-5">It builds on earlier standards (like the old IEEE 829 test plan format) but updates them to be relevant for modern testing practices. In short, ISO 29119-3 helps teams create comprehensive test plans that cover all necessary details, improving communication and test coverage across different project environments.</p>
</div>
HTML
create_info_step(course, "Introduction to ISO 29119-3", 1, intro_content)

tf_question = {
  prompt: "ISO 29119-3 applies only to agile methodologies.",
  correct_answer: false,
  success_message: "Correct! ISO 29119-3 is designed for all software development methodologies, not just Agile. It provides a structured approach to test planning that applies to Waterfall, DevOps, Agile, and hybrid models.",
  failure_message: "Not quite! ISO 29119-3 is not limited to Agile. It's a general test planning standard that can be used in any development context, including Waterfall and DevOps."
}
create_true_false_step(course, "True or False", 2, tf_question)

components_content = <<-HTML
<div id="iso-components" class="font-sans">
  <p class="leading-relaxed mb-6 max-w-4xl">
    What exactly goes into a test plan as per ISO 29119-3? The standard outlines several key components that every test plan should address. These components ensure that the plan paints a complete picture of <em>what</em> will be tested, <em>how</em>, <em>when</em>, <em>by whom</em>, and <em>with what considerations</em>.
  </p>
  <table class="w-full border-collapse my-8" aria-label="ISO 29119-3 Test Plan Components">
    <thead>
      <tr>
        <th scope="col" class="bg-gray-100 text-left p-3 border border-gray-300">Component</th>
        <th scope="col" class="bg-gray-100 text-left p-3 border border-gray-300">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Context of the Testing</td>
        <td class="p-3 align-top border border-gray-300">Describes the background and <em>scope</em> of testing – e.g., which project or subsystem this plan covers, what items (software components) will be tested, and the overall test <em>scope</em> (features to be tested or not tested). It essentially sets the boundaries and context for the plan.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Assumptions and Constraints</td>
        <td class="p-3 align-top border border-gray-300">Lists any conditions that are assumed to be true (e.g., "test environment will be available by 15th Oct") and any limitations or constraints affecting testing (e.g., hard deadlines, resource limitations, or dependencies).</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Stakeholders</td>
        <td class="p-3 align-top border border-gray-300">Identifies who has a stake in the testing effort and their roles, such as test team members, developers, project managers, and clients. The test plan should note key stakeholders and their interests.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Risk Register</td>
        <td class="p-3 align-top border border-gray-300">Documents identified risks, including <em>product risks</em> (quality risks) and <em>project risks</em> (process risks). Each risk includes an impact assessment and mitigation strategy.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Test Strategy</td>
        <td class="p-3 align-top border border-gray-300">Describes the overall approach to testing, including levels of testing, types of testing, design techniques, entry/exit criteria, and automation strategy.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Test Activities and Schedule (Estimates)</td>
        <td class="p-3 align-top border border-gray-300">Outlines the timeline and estimated effort for test phases and key activities.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Staffing and Roles</td>
        <td class="p-3 align-top border border-gray-300">Specifies team members involved in testing, their responsibilities, and any hiring or training needs.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Communication and Reporting</td>
        <td class="p-3 align-top border border-gray-300">Defines how test progress, risks, and issues will be communicated to stakeholders.</td>
      </tr>
      <tr>
        <td class="font-bold min-w-[150px] p-3 align-top border border-gray-300">Test Deliverables</td>
        <td class="p-3 align-top border border-gray-300">Lists the expected outputs from testing, such as test cases, scripts, reports, and defect logs.</td>
      </tr>
    </tbody>
  </table>
  <p class="leading-relaxed mb-6 max-w-4xl">
    ISO 29119-3 provides a structured template covering all these components. By addressing each, a test plan becomes a comprehensive guide ensuring clarity, coverage, and consistency in any testing project.
  </p>
  <div class="bg-gray-50 p-4 border-l-4 border-blue-500 my-6">
    Having all these sections in a test plan helps prevent omissions. For instance, if we only plan "what to test" but not "who will test" or "when," we'll likely hit problems later. ISO 29119-3 encourages thorough planning without prescribing <em>exactly</em> how you must write it – you can tailor the depth of each section based on your project's needs. For a small project, each section might be just a few sentences; for a large mission-critical project, each might be very detailed. The key is that the <strong>plan covers these categories</strong> so nothing important is overlooked.
  </div>
</div>
HTML
create_info_step(course, "Test Plan Components (ISO 29119-3)", 3, components_content)


mc_question = {
  prompt: "Which of the following is NOT a key component of a test plan according to ISO 29119-3?",
  success_message: "Correct! Detailed code implementation is not part of a test plan, as it focuses on planning the testing process rather than the software's internal design.",
  failure_message: "Not quite! Test plans focus on testing scope, risks, and roles—not the internal implementation of software features.",
  options: [
    { text: "Test Scope and Context", correct: false, feedback: "Test plans must define the scope and context to set testing boundaries." },
    { text: "Identified Risks and Mitigations", correct: false, feedback: "Risk management is essential in test planning to prepare for potential issues." },
    { text: "Roles and Responsibilities of Test Team", correct: false, feedback: "Test plans outline the responsibilities of team members involved in testing." },
    { text: "Detailed Code Implementation for Features", correct: true, feedback: "Correct! A test plan does not include software implementation details." }
  ]
}
create_multiple_choice_step(course, "Test Plan Components", 4, mc_question)

context_of_testing_content = <<-HTML
<div class="max-w-4xl mx-auto px-4 py-6 text-gray-800">
  <p class="mb-4 leading-relaxed">The <strong class="font-semibold">context of testing</strong> section in a test plan sets the stage for everything that follows. Think of it as the introduction to your test plan's story: it defines <em class="italic">where we are and what we're dealing with</em>. According to ISO 29119-3, "Context of the Testing" typically includes:</p>
  <ul class="space-y-4 mb-6 list-disc pl-5">
    <li class="leading-relaxed">
      <strong class="font-semibold">Project or System Background:</strong> A brief description of the project or system under test. For example, is this a web application, a mobile app, an API, etc.? What is the purpose of the system? This helps anyone reading the plan to understand the domain and importance of the testing.
    </li>
    <li class="leading-relaxed">
      <strong class="font-semibold">Test Items:</strong> A list of what items will be tested. In other words, which components or features are in scope? This could be specific modules (e.g., "Login Module, Payment Processing Service, Reporting Dashboard") or it could reference requirement IDs or user stories that will be tested.
    </li>
    <li class="leading-relaxed">
      <strong class="font-semibold">Test Scope (In-Scope & Out-of-Scope):</strong> This is crucial – it defines the <em class="italic">boundaries</em> of testing.
      The plan should summarize what features or aspects <strong class="font-semibold">will be tested</strong> (in-scope) and also explicitly state if anything will <strong class="font-semibold">not</strong> be tested (out-of-scope) and why.
    </li>
    <li class="leading-relaxed">
      <strong class="font-semibold">Assumptions and Constraints:</strong> Often considered part of context, this section outlines what we are treating as true for planning purposes (assumptions) and factors that limit testing (constraints).
    </li>
    <li class="leading-relaxed">
      <strong class="font-semibold">Test Environment & Contextual Info:</strong> The context section may also specify which environment or configuration the testing will use if known at this stage.
      For example: "Testing will be carried out on the staging server (version 1.2 of the software) using a copy of production data from Sept 1." This situational info helps frame how and where testing will happen.
    </li>
  </ul>
  <p class="mb-4 leading-relaxed">Overall, the context section's <em class="italic">importance</em> lies in defining the <strong class="font-semibold">scope and boundaries</strong> of the testing effort clearly. It prevents misunderstandings, ensuring that stakeholders understand <strong class="font-semibold">what's covered and what isn't</strong>.
    As ISO 29119-3 states, the test scope summary should list features to be tested and those explicitly not tested, along with rationale.
  </p>
</div>
HTML
create_info_step(course, "Context of Testing", 5, context_of_testing_content)

tf_question = {
  prompt: "The test context defines the scope and boundaries of testing.",
  correct_answer: true,
  success_message: "Correct! The 'Context of the Testing' section explicitly outlines the scope and boundaries of testing, ensuring clarity on what will and won’t be tested.",
  failure_message: "Not quite! The test context is specifically meant to define the testing scope and boundaries, clarifying what is in and out of scope."
}
create_true_false_step(course, "Context of Testing", 6, tf_question)

stakeholders_in_testing_content = <<-HTML
<div class="max-w-4xl mx-auto px-4 py-6 text-gray-800">
  <p class="mb-6 leading-relaxed"><em class="italic">Who cares about testing?</em> That's essentially what the <strong class="font-semibold">Stakeholders</strong> section of 29119-3 addresses. Stakeholders are all the people (or roles) who have an interest or stake in the testing of the project. Identifying stakeholders and their needs is important because test planning is not done in isolation – it should involve and inform the right people.</p>
  <h3 class="text-xl font-bold mb-4 text-gray-900 border-b pb-2">Identifying Key Stakeholders</h3>
  <p class="mb-4 leading-relaxed">Typical stakeholders in test planning include:</p>
  <ul class="space-y-3 mb-6 list-disc pl-5">
    <li class="leading-relaxed"><strong class="font-semibold">Test Manager / Test Lead:</strong> Responsible for creating the test plan and ensuring testing is carried out. (They care about all aspects of the plan.)</li>
    <li class="leading-relaxed"><strong class="font-semibold">Testing Team Members (QA Engineers, Testers):</strong> Execute the plan, write test cases, run tests, and report bugs. (They need clarity on tasks and available resources.)</li>
    <li class="leading-relaxed"><strong class="font-semibold">Developers / Development Team:</strong> They aren't testing, but they need to know when defects are found and may assist with bug fixes. (They care about defect reports and test outcomes related to their code.)</li>
    <li class="leading-relaxed"><strong class="font-semibold">Project Manager:</strong> Oversees the project schedule and resources. (They care about testing timelines, risks, and completion dates.)</li>
    <li class="leading-relaxed"><strong class="font-semibold">Product Owner or Business Analyst:</strong> Represents business requirements. (They ensure testing covers requirements and meets acceptance criteria.)</li>
    <li class="leading-relaxed"><strong class="font-semibold">Clients or End Users:</strong> For custom projects, they ultimately require the software to work. (They might not read the test plan, but their needs define what "done" means.)</li>
    <li class="leading-relaxed"><strong class="font-semibold">Other Specialists:</strong> This may include operations teams (for deployment concerns), security teams (for security testing), or any domain expert whose area intersects with testing.</li>
  </ul>
  <p class="mb-6 leading-relaxed">Stakeholders come from all parts of the organization, not just the testing team. For example, a database administrator might be a stakeholder if the test environment relies on their database.</p>
  <h3 class="text-xl font-bold mb-4 text-gray-900 border-b pb-2">Stakeholder Responsibilities and Interests</h3>
  <p class="mb-4 leading-relaxed">For each stakeholder or group, the test plan (or a communication plan) should clarify their involvement. Some examples:</p>
  <ul class="space-y-3 mb-6 list-disc pl-5">
    <li class="leading-relaxed">The <strong class="font-semibold">Test Manager</strong> approves the test plan and ensures execution, coordinating with others.</li>
    <li class="leading-relaxed">The <strong class="font-semibold">Project Manager</strong> provides resources for testing and expects regular status updates.</li>
    <li class="leading-relaxed">The <strong class="font-semibold">Developers</strong> fix defects, so they need a way to receive bug reports and testing feedback.</li>
    <li class="leading-relaxed">The <strong class="font-semibold">Business Analyst / Product Owner</strong> verifies that test cases cover all acceptance criteria and may sign off on UAT.</li>
  </ul>
  <p class="mb-6 leading-relaxed">Mapping these out ensures stakeholder needs are met. If customers are stakeholders, you may plan a user acceptance test phase for them.</p>
  <h3 class="text-xl font-bold mb-4 text-gray-900 border-b pb-2">Communication with Stakeholders</h3>
  <p class="mb-4 leading-relaxed">Once stakeholders are identified, the test plan (often in a "Testing Communication" section) should define how and when to communicate with them.</p>
  <ul class="space-y-3 mb-6 list-disc pl-5">
    <li class="leading-relaxed"><strong class="font-semibold">Test Lead</strong> will provide a <em class="italic">weekly status report</em> to the Project Manager and Product Owner.</li>
    <li class="leading-relaxed"><strong class="font-semibold">Critical defects</strong> will be immediately escalated to the Development Lead via email or Slack.</li>
    <li class="leading-relaxed">A <em class="italic">test plan review meeting</em> will be held with stakeholders (Dev Lead, BA, QA Lead) on Jan 10.</li>
    <li class="leading-relaxed">After test execution, a <em class="italic">test summary report</em> will be delivered to the client.</li>
  </ul>
  <p class="mb-6 leading-relaxed">This ensures stakeholders stay informed and provide input at the right times. It also sets expectations – e.g., developers know when bug reports will come, and managers know when they'll receive updates.</p>
  <h3 class="text-xl font-bold mb-4 text-gray-900 border-b pb-2">Why Manage Stakeholders?</h3>
  <p class="mb-4 leading-relaxed">A test plan that doesn't consider its audience may fail to get buy-in or miss critical details. Involving stakeholders ensures:</p>
  <ul class="space-y-3 mb-6 list-disc pl-5">
    <li class="leading-relaxed">A more complete plan, incorporating multiple perspectives.</li>
    <li class="leading-relaxed">Stakeholder support and investment in the process.</li>
    <li class="leading-relaxed">Prevention of issues like scheduling conflicts or missing resources.</li>
  </ul>
  <p class="mb-4 leading-relaxed">In ISO 29119-3, stakeholders and communication are emphasized: the test plan template lists stakeholders and their relevance to testing, as well as how communication will occur.</p>
</div>
HTML
create_info_step(course, "Stakeholders in Testing", 7, stakeholders_in_testing_content)


dropdown_match_stakeholders = {
  prompt: "Match each stakeholder to their primary responsibility in test planning:",
  matching_style: "dropdown",
  success_message: "Correct! Each stakeholder plays a specific role in test planning, from coordinating testing to ensuring requirements are covered.",
  failure_message: "Some matches are incorrect. Focus on each role’s main responsibility in testing.",
  pairs: [
  { term: "Test Manager / Test Lead", definition: "Coordinates the overall testing activities, prepares the test plan, and ensures the test team has what they need.", position: 1 },
  { term: "Developer", definition: "Fixes defects found during testing and may assist in setting up test environments or providing technical details to testers.", position: 2 },
  { term: "Business Analyst", definition: "Ensures testing aligns with requirements and helps clarify any requirement ambiguities for the test team.", position: 3 },
  { term: "Project Manager", definition: "Monitors project timelines and resources; needs testing status updates and ensures testing fits into the project schedule.", position: 4 }
  ]
}
create_matching_step(course, "Match the Stakeholders to Their Responsibilities", 8, dropdown_match_stakeholders)

risk_register_content = <<-HTML
<div class="max-w-4xl mx-auto px-4 py-6 text-gray-800">
  <p class="mb-4 leading-relaxed">A crucial part of a test plan is the <strong class="font-semibold">Risk Register</strong>. Identifying risks helps determine where testing should focus.</p>
  <p class="mb-6 leading-relaxed">ISO 29119-3 expects the test plan to identify risks considered in testing, including relevant risks from an organizational strategy. These risks typically fall into two categories:</p>
  <ul class="mb-6 space-y-6">
    <li class="bg-gray-50 p-4 rounded-lg shadow-sm">
      <h3 class="font-bold text-lg mb-3 text-gray-900">Product Risks</h3>
      <p class="mb-3 leading-relaxed">Risks <em class="italic">to the quality of the product</em>. For example:</p>
      <ul class="list-disc pl-5 space-y-2 mb-3">
        <li class="leading-relaxed">"The new payment module may fail under heavy load."</li>
        <li class="leading-relaxed">"There's a security risk of sensitive data leakage."</li>
      </ul>
      <p class="leading-relaxed text-gray-700">These risks influence where testing should focus (e.g., load testing, security testing).</p>
    </li>
    <li class="bg-gray-50 p-4 rounded-lg shadow-sm">
      <h3 class="font-bold text-lg mb-3 text-gray-900">Project (or Process) Risks</h3>
      <p class="mb-3 leading-relaxed">Risks <em class="italic">to the testing process or project schedule</em>. For example:</p>
      <ul class="list-disc pl-5 space-y-2 mb-3">
        <li class="leading-relaxed">"The test environment might not be ready on time."</li>
        <li class="leading-relaxed">"Only one tester is available, causing potential delays."</li>
        <li class="leading-relaxed">"A critical requirement is still not finalized, affecting test scope."</li>
      </ul>
      <p class="leading-relaxed text-gray-700">These risks inform contingency plans, such as buffer time or additional resources.</p>
    </li>
  </ul>
  <p class="mb-6 leading-relaxed">For each risk, a test plan should assign an <em class="italic">exposure level</em> (High/Medium/Low) based on impact and likelihood, and document the planned <em class="italic">mitigation or response</em>.</p>
  <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-6">
    <p class="leading-relaxed">For example, if "new module may fail under heavy load" is a high-risk item, the mitigation could be "plan a performance testing cycle and prioritize performance issues."</p>
  </div>
  <p class="mb-4 leading-relaxed">Common risk responses in testing include:</p>
  <ul class="list-disc pl-5 space-y-2 mb-6">
    <li class="leading-relaxed">Adding specific test cases.</li>
    <li class="leading-relaxed">Conducting proof-of-concept testing early.</li>
    <li class="leading-relaxed">Performing exploratory testing on high-risk areas.</li>
  </ul>
  <p class="leading-relaxed">By explicitly listing risks, the test plan demonstrates risk awareness and helps stakeholders monitor them. If a risk is out of scope or acceptable, that should be noted (e.g., "If the test environment isn't ready, we will use a backup environment or reschedule tests.").</p>
</div>
HTML
create_info_step(course, "Risk Register", 9, risk_register_content)

risk_mit_question = {
  prompt: "Which of these is a risk mitigation technique in the context of test planning?",
  success_message: "Correct! Risk-based testing focuses on the most critical and failure-prone areas, helping to mitigate high-impact issues before release.",
  failure_message: "Not quite! Risk mitigation involves proactively addressing risks, not ignoring or avoiding them.",
  options: [
  { text: "Focusing testing efforts on the most critical and likely-to-fail areas of the application.", correct: true, feedback: "Correct! This is risk-based testing, a common risk mitigation technique." },
  { text: "Ignoring identified risks to avoid overcomplicating the test plan.", correct: false, feedback: "Ignoring risks is not mitigation; it increases the chance of unexpected failures." },
  { text: "Assuming that all risks will resolve themselves over time without action.", correct: false, feedback: "This is wishful thinking, not mitigation. Risks require proactive handling." },
  { text: "Removing test cases for features that are risky or complex.", correct: false, feedback: "Risky features need more testing, not less. Removing test cases increases the risk of undetected defects." }
  ]
}
create_multiple_choice_step(course, "Risk Mitigation", 10, risk_mit_question)

test_strategy_content = <<-HTML
<div class="max-w-4xl mx-auto px-4 py-6 text-gray-800">
  <p class="mb-4 leading-relaxed">Another essential component of a test plan is the <strong class="font-semibold">Test Strategy</strong>, which describes the overall approach and design of testing for the project.</p>
  <p class="mb-4 leading-relaxed">It answers key questions such as:</p>
  <div class="bg-white rounded-lg shadow-md mb-8">
    <ul class="divide-y divide-gray-200">
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What levels of testing will be executed?</strong>
        <span class="text-gray-700">(e.g., unit, integration, system, UAT)</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What types of testing will be used?</strong>
        <span class="text-gray-700">(e.g., functional, performance, security, usability)</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What test techniques will be applied?</strong>
        <span class="text-gray-700">(e.g., equivalence partitioning, boundary value analysis, risk-based testing, exploratory testing)</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">How will regression testing be handled?</strong>
        <span class="text-gray-700">(e.g., automated regression suite, manual key case reruns)</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What are the entry and exit criteria?</strong>
        <span class="text-gray-700">(e.g., "Entry: test environment is ready; Exit: all critical defects fixed and 95% of planned tests passed.")</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What tools will be used?</strong>
        <span class="text-gray-700">(e.g., JIRA for bug tracking, Selenium for automation)</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What test data and environments are required?</strong>
        <span class="text-gray-700">(e.g., "We will use anonymized production data for testing in a staging server.")</span>
      </li>
      <li class="p-4 hover:bg-gray-50">
        <strong class="font-semibold text-gray-900 block mb-1">What standards or templates will be followed?</strong>
        <span class="text-gray-700">(e.g., following an organizational test process or specific test case format)</span>
      </li>
    </ul>
  </div>
  <p class="mb-4 leading-relaxed">The test strategy ensures that testing is <strong class="font-semibold">systematic</strong> and <strong class="font-semibold">aligned with project goals</strong>. If performance is a major risk, for example, the strategy should include performance testing.</p>
  <p class="mb-4 leading-relaxed">ISO 29119-3 treats the test strategy as part of the test plan, describing the approach for that specific project or test level.</p>
  <p class="mb-6 leading-relaxed">The strategy often contains subsections such as test design techniques, test environment, and completion criteria.</p>
</div>
HTML
create_info_step(course, "Test Strategy", 11, test_strategy_content)

test_strategy_question = {
  prompt: "Which of the following BEST describes the purpose of a test strategy in an ISO 29119-3 test plan?",
  success_message: "Correct! The test strategy outlines the overall approach to testing, including techniques, levels, and criteria that will be used to address the project risks.",
  failure_message: "Not quite. The test strategy is more than just a list of tests or schedule - it's the comprehensive approach to how testing will be conducted.",
  options: [
  { text: "To document the overall approach to testing, including test levels, techniques, and exit criteria that address identified risks.", correct: true, feedback: "Correct! The test strategy defines how testing will be systematically conducted to meet project goals and address risks." },
  { text: "To provide a detailed list of every test case that will be executed during the project.", correct: false, feedback: "This is too narrow. The strategy outlines the approach to testing, not the specific test cases." },
  { text: "To document when each test will be executed in the project timeline.", correct: false, feedback: "This is the test schedule, not the test strategy. The strategy focuses on how testing will be done." },
  { text: "To identify all possible risks that might affect the product quality.", correct: false, feedback: "This describes the risk register, not the test strategy. The strategy defines how to address those risks through testing." }
  ]
}
create_multiple_choice_step(course, "Test Strategy Understanding", 12, test_strategy_question)

test_act_and_est = <<-HTML
<div class="max-w-3xl mx-auto p-6 bg-white text-gray-800 leading-relaxed">
  <p class="mb-4">Once we know <em>what</em> we're testing (scope) and <em>how</em> we'll approach it (strategy), we need to plan <em>the work itself</em> – the <strong>test activities</strong>. This part of the test plan outlines the <strong>tasks</strong> the testing team will perform and the estimated effort required, which forms the basis of the test schedule. Proper planning ensures that:</p>
  <ul class="list-disc pl-6 mb-6 space-y-1">
    <li>Testing can be completed within the available time.</li>
    <li>Resource needs are identified early.</li>
    <li>Expectations for progress tracking are set.</li>
  </ul>
  <h3 class="text-xl font-semibold mt-8 mb-4 text-gray-900">Common Test Activities</h3>
  <p class="mb-4">Typical <strong>test activities</strong> in a test plan include:</p>
  <ul class="list-disc pl-6 mb-6 space-y-2">
    <li><strong class="text-gray-900">Test Planning & Preparation:</strong> E.g., "Finalize test plan document by X date."</li>
    <li><strong class="text-gray-900">Test Design / Test Case Development:</strong> Writing test cases or scripts. Example: "Design test cases for all user stories – estimated 5 days."</li>
    <li><strong class="text-gray-900">Test Environment Setup:</strong> Configuring test infrastructure. Example: "Set up staging environment and load test data – 2 days."</li>
    <li><strong class="text-gray-900">Test Execution:</strong> Running test cases, logging results, and reporting defects.</li>
    <li><strong class="text-gray-900">Defect Retesting & Confirmation:</strong> Verifying fixed defects and regression testing.</li>
    <li><strong class="text-gray-900">Performance/Load Testing:</strong> If applicable, scheduled separately.</li>
    <li><strong class="text-gray-900">Test Closure Activities:</strong> Summarizing results, preparing reports, archiving test artifacts.</li>
    <li><strong class="text-gray-900">Meetings and Communication:</strong> Time for daily stand-ups, test reviews, or stakeholder updates.</li>
  </ul>
  <h3 class="text-xl font-semibold mt-8 mb-4 text-gray-900">Estimating Test Effort</h3>
  <p class="mb-4">The test plan should provide an <strong>estimate</strong> for each activity, using metrics such as person-days, hours, or calendar time. Examples:</p>
  <ul class="list-disc pl-6 mb-6 space-y-1">
    <li>Test case design: <em>~10 person-days</em> (two testers working 1 week).</li>
    <li>Test execution: <em>~20 person-days</em> spread over 3 calendar weeks.</li>
  </ul>
  <p class="mb-6">These estimates are based on past experience or scope complexity analysis.</p>
  <h3 class="text-xl font-semibold mt-8 mb-4 text-gray-900">Planning Test Activities and Schedule</h3>
  <p class="mb-4">A structured approach to planning includes:</p>
  <ol class="list-decimal pl-6 mb-6 space-y-2">
    <li><strong class="text-gray-900">Identify and break down tasks</strong> – List all testing tasks.</li>
    <li><strong class="text-gray-900">Estimate each task</strong> – Use historical data or expert judgment.</li>
    <li><strong class="text-gray-900">Assign resources</strong> – Determine team size and availability.</li>
    <li><strong class="text-gray-900">Consider contingencies</strong> – Add buffers for potential delays.</li>
    <li><strong class="text-gray-900">Schedule tasks</strong> – Align test activities with the project timeline.</li>
  </ol>
  <h3 class="text-xl font-semibold mt-8 mb-4 text-gray-900">Example Test Schedule</h3>
  <p class="mb-4">Assuming a two-month project timeline, a test schedule could be:</p>
  <ul class="pl-6 mb-6 space-y-2 list-disc">
    <li><strong class="text-gray-900">Week 1-2:</strong> Test Design</li>
    <li><strong class="text-gray-900">Week 3:</strong> Setup and prepare environment</li>
    <li><strong class="text-gray-900">Week 4-5:</strong> Test Execution Round 1</li>
    <li><strong class="text-gray-900">Week 6:</strong> Bug fixes by developers (testers may do exploratory testing)</li>
    <li><strong class="text-gray-900">Week 7:</strong> Re-test and Regression</li>
    <li><strong class="text-gray-900">Week 8:</strong> Test closure and contingency</li>
  </ul>
  <p class="mb-6">By planning this way, we can identify potential risks like development delays squeezing the testing phase, which could be noted as a risk in the test plan.</p>
  <h3 class="text-xl font-semibold mt-8 mb-4 text-gray-900">Importance of Estimation in Test Planning</h3>
  <p class="mb-4"><strong>Estimation</strong> is challenging but essential. If we say "Execution will be done by March 10," stakeholders will expect that timeline. That's why test plans often include assumptions like:</p>
  <ul class="list-disc pl-6 mb-6 space-y-1">
    <li>"Assuming no major blocker."</li>
    <li>"Assuming 5 testers available."</li>
  </ul>
  <p class="mb-4">If conditions change, estimates and schedules may need adjustment.</p>
  <p class="mb-2">In summary, <strong>Test Activities and Estimates</strong> translate the test strategy into a concrete timeline and resource plan, ensuring structured execution. Without this, a plan would lack clarity on how to achieve its goals within time constraints.</p>
</div>
HTML
create_info_step(course, "Test Activities and Estimates", 13, test_act_and_est)

test_act_ord_data = {
  prompt: "Place the following steps for estimating test activities in the correct order:",
  success_message: "Great job! You've correctly ordered the steps for estimating test activities.",
  failure_message: "That's not quite right. Remember to start by defining the tasks before estimating them.",
  items: [
    { content: "Break down the testing work into specific tasks/activities", correct_position: 1 },
    { content: "Estimate the effort required for each identified test task", correct_position: 2 },
    { content: "Add contingency (buffer) time to account for risks or uncertainties", correct_position: 3 },
    { content: "Review and adjust the estimates with the team or stakeholders", correct_position: 4 },
    { content: "Finalise the schedule and incorporate any buffer time, producing a timeline for testing", correct_position: 5 }
  ]
}
create_ordering_step(course, "Estimating Test Activities", 14, test_act_ord_data)

staffing_and_communication_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <p class="mb-4">A test plan isn't complete until it addresses the <strong>people aspect</strong> – who will do the work and how information will flow. The <strong>Staffing</strong> part of the plan outlines human resources for testing, while the <strong>Communication</strong> section details how the test team will interact with project stakeholders.</p>
    <h3 class="text-xl font-bold text-blue-700 mt-8 mb-4">Staffing (Roles and Responsibilities)</h3>
    <p class="mb-4">Previously, we identified stakeholders and roles at a high level. The staffing section of the test plan provides specifics about the test team's composition. It may include:</p>
    <ul class="mb-6 ml-6 list-disc space-y-2">
      <li><strong class="text-gray-900">Team Structure:</strong> E.g., "We will have 1 Test Lead (Alice) and 3 Test Engineers (Bob, Charlie, Dana) on this project." This may include an org chart if multiple teams are involved.</li>
      <li><strong class="text-gray-900">Role Descriptions:</strong> E.g., "Test Lead will coordinate with PM and Dev team, Test Engineers will design and execute tests. A Performance Testing Specialist (Eve) will be brought in for week 3 for load testing."</li>
      <li><strong class="text-gray-900">Resource Availability:</strong> E.g., "Bob is 50% allocated because he's on another project." Notes on part-time availability or team member start/end dates should be included.</li>
      <li><strong class="text-gray-900">Training Needs:</strong> If new tools or domain knowledge are required, the plan should state training requirements. E.g., "Testers will receive a one-day training on the new test management tool on Jan 5th."</li>
      <li><strong class="text-gray-900">Hiring or Outsourcing:</strong> If additional testers or external contractors are needed, the plan should outline the hiring strategy. E.g., "Plan to hire 2 temporary testers in Feb to help meet the deadline."</li>
    </ul>
    <p class="mb-6">By explicitly defining staffing, stakeholders (especially project managers) can assess whether enough people are assigned and adjust resources if necessary. ISO 29119-3 suggests documenting <strong>hiring needs or training needs</strong> as part of staffing.</p>
    <h3 class="text-xl font-bold text-blue-700 mt-8 mb-4">Communication and Reporting</h3>
    <p class="mb-4">Communication overlaps with stakeholders and risk management but focuses on <strong>how information flows</strong> between teams. A dedicated communication plan might include:</p>
    <ul class="mb-6 ml-6 list-disc space-y-3">
      <li><strong class="text-gray-900">Reporting Structure:</strong> Who do testers report to? E.g., "Testers will report daily progress and any blockers to the Test Lead. The Test Lead will attend the Project Scrum meeting to report overall testing status."</li>
      <li><strong class="text-gray-900">Meetings:</strong> Scheduled touchpoints such as:
        <ul class="mt-2 ml-6 list-disc space-y-1">
          <li>"Weekly Test Status Meeting every Friday with Dev and PM."</li>
          <li>"Defect triage meetings on demand when critical bugs arise."</li>
        </ul>
      </li>
      <li><strong class="text-gray-900">Status Reports:</strong> Frequency and format. E.g., "Test Lead will send out a Test Execution Status email three times a week listing test cases run, pass/fail counts, and high-priority bugs."</li>
      <li><strong class="text-gray-900">Escalation Path:</strong> Defines how blockers are handled. E.g., "Any blocking issues will be escalated to the Project Manager and relevant team lead immediately. If unresolved within 24 hours, it will be escalated to the Steering Committee."</li>
      <li><strong class="text-gray-900">Tool Usage for Communication:</strong> E.g., "All defects will be logged in JIRA and automatically visible to the dev team. Testing progress will be tracked in JIRA dashboards."</li>
    </ul>
    <p class="mb-6">A well-defined communication plan prevents situations where critical bugs go unnoticed or testers are unclear on whom to contact for missing information.</p>
    <h3 class="text-xl font-bold text-blue-700 mt-8 mb-4">Reporting Lines Can Vary</h3>
    <p class="mb-6">Reporting structures depend on the project organization. In some companies, testers report to a central manager (e.g., Head of Testing/QA), while in others, they report directly to the Project Manager or Scrum Master. In agile teams, testers might functionally report to the Delivery Lead but also maintain a reporting line to a QA Manager. The test plan should clarify these relationships.</p>
  </div>
HTML
create_info_step(course, "Staffing and Communication", 15, staffing_and_communication_content)

tester_reporting_structure = {
  prompt: "Testers report only to the Head of Testing in all projects.",
  correct_answer: false,
  success_message: "Correct! Tester reporting structures vary. While some testers report to a Head of Testing, many follow a dual-reporting structure where they also report to a project lead, Scrum Master, or Project Manager.",
  failure_message: "Not quite! Tester reporting depends on the organization. Many testers report within their project team while also maintaining a reporting line to a Head of Testing."
}
create_true_false_step(course, "Tester Reporting Structures", 16, tester_reporting_structure)

test_schedule_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <p class="mb-4">The <strong>test schedule</strong> ensures that test activities align with project timelines and deliverables. Scheduling varies based on the development approach:</p>
    <h3 class="text-xl font-bold text-blue-700 mt-8 mb-4">Traditional Projects</h3>
    <p class="mb-4">In traditional projects, test schedules are typically represented using a <strong>Gantt chart</strong>, which visualises:</p>
    <ul class="mb-6 ml-6 list-disc space-y-2">
      <li>Key milestones such as test planning, execution, and completion dates.</li>
      <li>Dependencies between tasks (e.g., test execution cannot begin until test case design is complete).</li>
      <li>Resource allocation over time.</li>
    </ul>

    <h3 class="text-xl font-bold text-blue-700 mt-8 mb-4">Agile Projects</h3>
    <p class="mb-4">Agile teams use different scheduling techniques to track progress in an iterative manner. Common methods include:</p>
    <ul class="mb-6 ml-6 list-disc space-y-2">
      <li><strong class="text-gray-900">Sprint Boards:</strong> Organise tasks into columns such as "To Do," "In Progress," and "Done" to provide visibility into ongoing testing activities.</li>
      <li><strong class="text-gray-900">Kanban Boards:</strong> Help manage test execution flow with work-in-progress limits to prevent bottlenecks.</li>
    </ul>
    <h3 class="text-xl font-bold text-blue-700 mt-8 mb-4">Importance of Test Scheduling</h3>
    <p class="mb-4">Regardless of methodology, an effective test schedule:</p>
    <ul class="mb-6 ml-6 list-disc space-y-2">
      <li>Ensures test activities align with release timelines.</li>
      <li>Allows stakeholders to anticipate delays and make adjustments.</li>
      <li>Improves resource management by highlighting workload distribution.</li>
    </ul>
  </div>
HTML
create_info_step(course, "Test Schedule", 17, test_schedule_content)

test_schedule_multiple_choice = {
  prompt: "Which of the following is a common method for tracking test schedules in agile projects?",
  success_message: "Correct! Sprint boards, Kanban boards, and iterative tracking methods are commonly used in agile projects.",
  failure_message: "That's incorrect. Agile projects rely on dynamic tracking methods rather than static schedules.",
  options: [
  { text: "A fixed Gantt chart updated only at the start", correct: false, feedback: "Gantt charts are more common in traditional project management." },
  { text: "A sprint board that tracks tasks throughout the iteration", correct: true, feedback: "Correct! Sprint boards are commonly used in agile projects." },
  { text: "A printed calendar with static milestones", correct: false, feedback: "Static calendars don't adapt to agile workflows." },
  { text: "A one-time schedule with no revisions", correct: false, feedback: "Agile projects require continuous schedule adjustments." }
]
}
create_multiple_choice_step(course, "Test Schedule - Multiple Choice", 18, test_schedule_multiple_choice)

scenario_intro_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <p class="mb-4">Let's explore how the ISO 29119-3 concepts apply to a realistic scenario. We'll examine a fictional company and project to illustrate test planning in action:</p>
    <div class="bg-blue-50 rounded-lg p-5 my-6 border border-blue-100 shadow-sm">
        <h3 class="text-lg font-bold text-blue-700 mb-3">Our Scenario</h3>
        <p class="mb-3"><strong class="text-gray-900">Agile Corporation</strong> is creating a <strong class="text-gray-900">New Subscription System (NSS)</strong>. The project is using <strong class="text-gray-900">Scrum</strong> with two-week sprints.</p>
        <p class="mb-3">The system handles subscription functions, including <strong class="text-gray-900">sign-ups, payments, renewals, notifications</strong>, and more.</p>
        <p class="mb-0">We're currently preparing for <strong class="text-gray-900">Iteration 3</strong>, which includes:</p>
        <ul class="ml-6 mt-2 list-disc space-y-1">
            <li><strong class="text-gray-900">Story 101:</strong> Credit Card Payment</li>
            <li><strong class="text-gray-900">Story 102:</strong> Email Notification for Successful Subscriptions</li>
        </ul>
    </div>
    <p class="mb-4">In the next sections, we'll create a test plan for this iteration following the <strong>ISO 29119-3</strong> structure you've learned about. We'll demonstrate how to apply these principles to an agile project.</p>
    <div class="bg-amber-50 border-l-4 border-amber-400 p-5 my-6 rounded-r-lg">
      <h4 class="text-amber-800 font-bold mb-2">Time for a Break?</h4>
      <p class="text-amber-700 mb-0">If you've been working through this course in one sitting, now might be a good time for a short break! The material can be mentally demanding, and taking time to absorb what you've learned so far will help with understanding the upcoming applied example. Remember, you can return to this course at any time - your progress is saved automatically.</p>
    </div>
  </div>
HTML
create_info_step(course, "A Practical Application Example", 19, scenario_intro_content)

context_of_testing_content = <<-HTML
<p class="mb-5">In this scenario, the testing context section of our test plan would establish the boundaries and focus of our testing efforts for the upcoming iteration:</p>
<div class="bg-gray-50 rounded-lg p-6 my-6 border border-gray-200 shadow-sm">
    <ul class="space-y-4">
        <li class="flex items-start">
            <span class="font-bold text-blue-700 min-w-32 inline-block">Project:</span>
            <span>New Subscription System (NSS)</span>
        </li>
        <li class="flex items-start">
            <span class="font-bold text-blue-700 min-w-32 inline-block">Iteration:</span>
            <span>3 (Two-week Sprint)</span>
        </li>
        <li class="flex items-start">
            <span class="font-bold text-blue-700 min-w-32 inline-block">Features in Scope:</span>
            <div class="ml-1">
                <p class="mb-2">User stories planned for this iteration:</p>
                <ul class="ml-6 list-disc space-y-2">
                    <li><strong class="text-gray-900">Story 101 –</strong> Implement credit card payment functionality</li>
                    <li><strong class="text-gray-900">Story 102 –</strong> Email notification on successful subscription</li>
                </ul>
            </div>
        </li>
        <li class="flex items-start">
            <span class="font-bold text-blue-700 min-w-32 inline-block">Testing Approach:</span>
            <span>All test levels and types for these stories will be addressed within the sprint timeframe.</span>
        </li>
        <li class="flex items-start">
            <span class="font-bold text-blue-700 min-w-32 inline-block">Out of Scope:</span>
            <span>Features not changed in this iteration, including subscription cancellation and reporting.</span>
        </li>
    </ul>
</div>
<p class="text-gray-600 italic mt-4">This context section clearly defines what will and won't be tested during Iteration 3, helping the team maintain focus and set appropriate expectations with stakeholders.</p>
HTML
create_info_step(course, "Context of Testing", 20, context_of_testing_content)

multiple_choice_question = {
  prompt: "In an agile project’s test plan for Iteration 3, which of the following is most appropriate to include?",
  success_message: "Correct! In an agile project, the test plan (often brief) should specify the scope and approach for the **current** sprint/iteration.",
  failure_message: "That's not right. The test plan should focus on the current sprint, not the entire project or a rigid, unchangeable schedule.",
  options: [
  { text: "A statement that no plan is required because the project is agile.", correct: false, feedback: "Agile projects still require planning, just in a lightweight format." },
  { text: "A detailed list of every test case for the entire project.", correct: false, feedback: "Agile focuses on iterative planning rather than documenting everything upfront." },
  { text: "A clear outline of what will be tested during the current two-week sprint.", correct: true, feedback: "Correct! Agile test plans should focus on the current sprint’s testing scope." },
  { text: "A fixed schedule covering all sprints until project completion, with no changes allowed.", correct: false, feedback: "Agile allows flexibility and adjustments in planning as the project progresses." }
]
}
create_multiple_choice_step(course, "Multiple Choice", 21, multiple_choice_question)

true_false_regression_testing = {
  prompt: "The test plan for Iteration 3 should only cover the credit card and email notification features. There is no requirement to test any previous features once they have been accepted in prior sprints.",
  success_message: "Correct! Agile often includes some level of regression testing to ensure new changes have not broken existing functionality.",
  failure_message: "Not quite. While the test plan primarily focuses on new or changed items, regression testing is often included to catch unintended issues.",
  correct_answer: false
}
create_true_false_step(course, "True or False", 22, true_false_regression_testing)

stakeholders_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <h2 class="text-2xl font-bold text-blue-800 mb-6 pb-2 border-b border-gray-200">Project Stakeholders & Communication</h2>
    <p class="mb-5">In this scenario, the stakeholders section of our test plan would identify all parties with an interest in the testing activities:</p>
    <div class="bg-gray-50 rounded-lg p-6 mb-8 border border-gray-200 shadow-sm">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Key Stakeholders in This Project</h3>
        <ul class="space-y-3 mb-0">
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Product Owner (PO):</span>
                <span>Defines acceptance criteria, prioritizes user stories, and provides final approval</span>
            </li>
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Delivery (Scrum) Lead:</span>
                <span>Facilitates the sprint process, monitors progress, and helps remove blockers</span>
            </li>
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Developers:</span>
                <span>Write unit tests, implement code, and fix defects identified during testing</span>
            </li>
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Testers (QA):</span>
                <span>Design test scenarios, execute tests (manual or automated), and track issues</span>
            </li>
        </ul>
    </div>

    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Communication Plan</h3>
        <ul class="space-y-3 mb-0">
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Daily Stand-ups:</span>
                <span>9:30 AM each workday - team shares progress, plans, and raises any testing impediments</span>
            </li>
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Sprint Review:</span>
                <span>Last day of sprint at 2:00 PM - demonstration of completed features with PO confirmation of acceptance</span>
            </li>
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Defect Reporting:</span>
                <span>All issues logged in JIRA with severity/priority classification</span>
            </li>
            <li class="flex items-start">
                <span class="font-bold text-gray-900 min-w-40 inline-block">Escalation Path:</span>
                <span>Blocking issues escalated to Scrum Lead immediately; Head of Testing informed of significant quality concerns but not involved in daily operations</span>
            </li>
        </ul>
    </div>
    <p class="text-gray-600 italic mt-4">This stakeholder and communication plan ensures everyone knows their role in the testing process and how information will flow throughout the iteration.</p>
</div>
HTML
create_info_step(course, "Stakeholders in Agile Testing", 23, stakeholders_content)

match_stakeholders_dropdown = {
  prompt: "Given the stakeholders that have just been described, match them to the best description of their test-related responsibility in an agile setting:",
  matching_style: "dropdown",
  success_message: "Correct! You've matched the stakeholders to their responsibilities accurately.",
  failure_message: "Some matches are incorrect.",
  pairs: [
    { term: "Product Owner", definition: "Defines acceptance criteria and approves features as 'Done.'", position: 1 },
    { term: "Developers", definition: "Implements code, writes unit tests, fixes bugs identified during system testing.", position: 2 },
    { term: "Testers", definition: "Executes system-level and acceptance-level tests, logs defects, and reports on test progress.", position: 3 },
    { term: "Delivery Lead", definition: "Manages sprint progress, helps remove any blocks, oversees quality goals for the team.", position: 4 }
  ]
}
create_matching_step(course, "Match the Stakeholders to Their Responsibilities", 24, match_stakeholders_dropdown)

risk_register_info = <<-HTML
<p class="mb-5">In Iteration 3, the following potential risks have been identified that could impact our testing effectiveness:</p>
<div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm">
    <ul class="space-y-4 mb-0">
        <li class="flex items-start">
            <div class="mt-1 text-red-500 mr-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                </svg>
            </div>
            <div>
                <span class="font-bold text-gray-900">Limited Payment Testing Environment:</span>
                <p class="text-gray-700 mt-1">No access to real credit card processing for testing, which could affect the realism and thoroughness of payment tests</p>
            </div>
        </li>
        <li class="flex items-start">
            <div class="mt-1 text-red-500 mr-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                </svg>
            </div>
            <div>
                <span class="font-bold text-gray-900">Sprint Timeline Constraints:</span>
                <p class="text-gray-700 mt-1">The two-week sprint provides limited testing time. Risk that not all stories will be thoroughly tested if one story contains numerous defects</p>
            </div>
        </li>
        <li class="flex items-start">
            <div class="mt-1 text-red-500 mr-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                </svg>
            </div>
            <div>
                <span class="font-bold text-gray-900">Technical Debt:</span>
                <p class="text-gray-700 mt-1">Carry-over defects from previous sprints may remain unresolved, potentially affecting new functionality or complicating regression testing</p>
            </div>
        </li>
    </ul>
</div>
HTML
create_info_step(course, "Risk Register", 25, risk_register_info)

risk_multiple_choice = {
  prompt: "Based on the risks identified in Iteration 3, which of the following would be the most appropriate risk mitigation technique for the payment testing limitation?",
  success_message: "Correct! This approach addresses the risk of limited payment testing environments while still enabling thorough testing.",
  failure_message: "Not quite! An effective risk mitigation strategy should address the specific challenge without compromising quality.",
  options: [
  { text: "Delay the payment feature to the next iteration.", correct: false, feedback: "Delaying may not be necessary if a sandbox or test environment is available." },
  { text: "Use a sandbox or simulated payment gateway for initial tests, and perform a near-production test if possible.", correct: true, feedback: "Correct! This approach allows for iterative testing while preparing for a more realistic validation." },
  { text: "Skip testing payments entirely until production is ready.", correct: false, feedback: "Skipping testing can introduce risks and make defect resolution harder later." },
  { text: "Conduct only manual tests without any integration checks.", correct: false, feedback: "Manual tests alone may not fully validate the payment process in an integrated environment." }
  ]
}
create_multiple_choice_step(course, "Risk Mitigation in Test Planning", 26, risk_multiple_choice)

test_strategy_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <p class="mb-5">For Iteration 3, the test strategy has been defined as follows:</p>
    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm">
        <ul class="space-y-4 mb-0">
            <li class="flex items-start">
                <div class="mt-1 text-blue-500 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                    </svg>
                </div>
                <div>
                    <span class="font-bold text-gray-900">Acceptance Test-Driven Development (ATDD):</span>
                    <p class="text-gray-700 mt-1">Define acceptance tests collaboratively with the Product Owner as part of story refinement, before development begins</p>
                </div>
            </li>
            <li class="flex items-start">
                <div class="mt-1 text-blue-500 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                    </svg>
                </div>
                <div>
                    <span class="font-bold text-gray-900">Unit & Integration Tests:</span>
                    <p class="text-gray-700 mt-1">Developers will implement unit tests for individual components and integration tests for interconnected modules, with test team providing guidance</p>
                </div>
            </li>
            <li class="flex items-start">
                <div class="mt-1 text-blue-500 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                    </svg>
                </div>
                <div>
                    <span class="font-bold text-gray-900">System Tests & System Integration Tests:</span>
                    <p class="text-gray-700 mt-1">Testers will verify end-to-end flows, including credit card payment process through the sandbox payment gateway and email notification delivery</p>
                </div>
            </li>
            <li class="flex items-start">
                <div class="mt-1 text-blue-500 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                    </svg>
                </div>
                <div>
                    <span class="font-bold text-gray-900">Regression Tests:</span>
                    <p class="text-gray-700 mt-1">Execute automated regression suite daily to ensure new changes don't break existing functionality, with focus on previously completed subscription features</p>
                </div>
            </li>
        </ul>
    </div>
</div>
HTML
create_info_step(course, "Test Strategy", 27, test_strategy_content)

true_false_regression_testing = {
  prompt: "Automated tests can help maintain regression coverage in agile projects.",
  success_message: "Correct! Automation supports fast feedback in short sprints.",
  failure_message: "Not quite. Automated tests help ensure that new changes do not break existing functionality.",
  correct_answer: true
}
create_true_false_step(course, "Automated Tests and Regression Testing", 28, true_false_regression_testing)

true_false_acceptance_testing = {
  prompt: "In an agile approach, acceptance tests only happen at the very end of the entire project.",
  success_message: "Correct! Acceptance tests usually happen each iteration once a story is 'Done.'",
  failure_message: "Not quite. In agile, acceptance tests occur iteratively, not just at the end of the project.",
  correct_answer: false
}
create_true_false_step(course, "Acceptance Testing in an Agile Scenario", 29, true_false_acceptance_testing)

test_activity_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <h2 class="text-2xl font-bold text-blue-800 mb-6 pb-2 border-b border-gray-200">Test Schedule</h2>
    <p class="mb-5">Within our two-week sprint for Iteration 3, the testing activities will follow this timeline:</p>
    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm mb-6">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Sprint Timeline</h3>
        <div class="space-y-5">
            <div class="flex items-start">
                <div class="min-w-32 font-bold text-gray-900">Sprint Day 1-2:</div>
                <div class="ml-2">
                    <p class="text-gray-700">Brief test planning discussions during sprint planning</p>
                    <p class="text-gray-700">Acceptance criteria refinement with Product Owner</p>
                    <p class="text-gray-700">Initial test case design begins</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="min-w-32 font-bold text-gray-900">Days 3-9:</div>
                <div class="ml-2">
                    <p class="text-gray-700">Test case design continues alongside development</p>
                    <p class="text-gray-700">Test execution begins as stories reach a "testable" state</p>
                    <p class="text-gray-700">Daily defect triage with developers</p>
                    <p class="text-gray-700">Automated tests created for regression suite</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="min-w-32 font-bold text-gray-900">Days 10-13:</div>
                <div class="ml-2">
                    <p class="text-gray-700">Exploratory testing sessions</p>
                    <p class="text-gray-700">Broader system integration testing</p>
                    <p class="text-gray-700">Verification of fixed defects</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="min-w-32 font-bold text-gray-900">Day 14:</div>
                <div class="ml-2">
                    <p class="text-gray-700">Final regression test pass</p>
                    <p class="text-gray-700">Preparation for demo in sprint review</p>
                    <p class="text-gray-700">Documentation of any known issues</p>
                </div>
            </div>
        </div>
    </div>

    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Resource Allocation</h3>
        <p class="mb-3">Estimates are allocated per user story:</p>
        <div class="space-y-4">
            <div class="flex items-start">
                <div class="min-w-44 font-bold text-gray-900">Story 101 (Credit Card Payment):</div>
                <div class="ml-2">
                    <p class="text-gray-700">~3 person-days of testing effort</p>
                    <p class="text-gray-700">Primary: Tester A (2 days)</p>
                    <p class="text-gray-700">Support: Tester B (1 day)</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="min-w-44 font-bold text-gray-900">Story 102 (Email Notification):</div>
                <div class="ml-2">
                    <p class="text-gray-700">~2 person-days of testing effort</p>
                    <p class="text-gray-700">Primary: Tester B (1.5 days)</p>
                    <p class="text-gray-700">Support: Tester A (0.5 day)</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="min-w-44 font-bold text-gray-900">Regression Testing:</div>
                <div class="ml-2">
                    <p class="text-gray-700">~2 person-days shared between both testers</p>
                </div>
            </div>
        </div>
    </div>
</div>
HTML
create_info_step(course, "Test Activities & Estimates", 30, test_activity_content)

risk_complex_story = {
  prompt: "The team foresees that Story 102, Email Notification, might exceed the planned test effort. How should the test plan reflect this risk?",
  success_message: "Correct! Agile test planning is iterative. If a story has higher complexity, the team should raise this during planning and focus on key risks first.",
  failure_message: "Not quite! The best approach is to prioritise testing based on risk, rather than skipping, rigidly following a plan, or outsourcing without coordination.",
  options: [
    { text: "Remove all tests to stay on schedule.", correct: false, feedback: "Skipping tests entirely increases risk and undermines quality." },
    { text: "Inform the team and consider risk-based prioritisation to cover the most important scenarios first.", correct: true, feedback: "Correct! Prioritising critical scenarios ensures essential coverage within time constraints." },
    { text: "Stick to a rigid plan and test every scenario in detail, no matter how long it takes.", correct: false, feedback: "Agile requires flexibility; testing every scenario in detail may not be practical." },
    { text: "Outsource the entire story to external testers without telling the team.", correct: false, feedback: "Testing decisions should be transparent and collaborative within the team." }
  ]
}
create_multiple_choice_step(course, "Handling Complex User Stories in Testing", 31, risk_complex_story)

staffing_roles = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <p class="mb-5">For Iteration 3, the following team members will be involved in testing activities:</p>
    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm mb-6">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Team Composition</h3>
        <div class="grid md:grid-cols-2 gap-5">
            <div class="bg-white p-4 rounded shadow-sm border border-blue-100">
                <div class="flex items-center mb-3">
                    <div class="p-2 bg-blue-100 rounded-full mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                        </svg>
                    </div>
                    <h4 class="font-bold text-gray-900">Tester A (Maria)</h4>
                </div>
                <p class="text-gray-700">Primary focus on credit card payment functionality and API testing</p>
                <p class="text-gray-700 mt-1">Automation skills for regression tests</p>
            </div>
            <div class="bg-white p-4 rounded shadow-sm border border-blue-100">
                <div class="flex items-center mb-3">
                    <div class="p-2 bg-blue-100 rounded-full mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                        </svg>
                    </div>
                    <h4 class="font-bold text-gray-900">Tester B (James)</h4>
                </div>
                <p class="text-gray-700">Primary focus on email notifications and UI testing</p>
                <p class="text-gray-700 mt-1">Exploratory testing expertise</p>
            </div>
            <div class="bg-white p-4 rounded shadow-sm border border-blue-100">
                <div class="flex items-center mb-3">
                    <div class="p-2 bg-blue-100 rounded-full mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                        </svg>
                    </div>
                    <h4 class="font-bold text-gray-900">Developer 1 (Alex)</h4>
                </div>
                <p class="text-gray-700">Implements payment integration code</p>
                <p class="text-gray-700 mt-1">Responsible for unit tests on payment module</p>
            </div>
            <div class="bg-white p-4 rounded shadow-sm border border-blue-100">
                <div class="flex items-center mb-3">
                    <div class="p-2 bg-blue-100 rounded-full mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                        </svg>
                    </div>
                    <h4 class="font-bold text-gray-900">Developer 2 (Priya)</h4>
                </div>
                <p class="text-gray-700">Implements email notification system</p>
                <p class="text-gray-700 mt-1">Responsible for unit tests on notification module</p>
            </div>
            <div class="bg-white p-4 rounded shadow-sm border border-blue-100">
                <div class="flex items-center mb-3">
                    <div class="p-2 bg-blue-100 rounded-full mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                        </svg>
                    </div>
                    <h4 class="font-bold text-gray-900">Product Owner (Sarah)</h4>
                </div>
                <p class="text-gray-700">Defines acceptance criteria</p>
                <p class="text-gray-700 mt-1">Participates in acceptance testing</p>
            </div>
            <div class="bg-white p-4 rounded shadow-sm border border-blue-100">
                <div class="flex items-center mb-3">
                    <div class="p-2 bg-blue-100 rounded-full mr-3">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                        </svg>
                    </div>
                    <h4 class="font-bold text-gray-900">Delivery Lead (Marcus)</h4>
                </div>
                <p class="text-gray-700">Tracks progress and removes impediments</p>
                <p class="text-gray-700 mt-1">Ensures testing resources are available</p>
            </div>
        </div>
    </div>

    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Collaboration Methods</h3>
        <div class="md:flex space-y-4 md:space-y-0 md:space-x-4">
            <div class="flex-1 bg-white p-4 rounded shadow-sm border border-blue-100">
                <h4 class="font-bold text-gray-900 mb-2">Daily Meetings</h4>
                <ul class="space-y-2 list-disc ml-5 text-gray-700">
                    <li>15-minute daily standup at 9:30 AM</li>
                    <li>Testing status shared by QA team</li>
                    <li>Impediments raised for immediate attention</li>
                </ul>
            </div>
            <div class="flex-1 bg-white p-4 rounded shadow-sm border border-blue-100">
                <h4 class="font-bold text-gray-900 mb-2">Paired Testing</h4>
                <ul class="space-y-2 list-disc ml-5 text-gray-700">
                    <li>Developers and testers pair on complex test cases</li>
                    <li>Testers collaborate on exploratory sessions</li>
                    <li>Three pairing sessions scheduled weekly</li>
                </ul>
            </div>
            <div class="flex-1 bg-white p-4 rounded shadow-sm border border-blue-100">
                <h4 class="font-bold text-gray-900 mb-2">Communication Tools</h4>
                <ul class="space-y-2 list-disc ml-5 text-gray-700">
                    <li>JIRA for defect tracking</li>
                    <li>Slack channel for real-time communication</li>
                    <li>Shared test documentation in Confluence</li>
                </ul>
            </div>
        </div>
    </div>
</div>
HTML
create_info_step(course, "Test Resources & Staffing", 32, staffing_roles)

true_false_dev_testing = {
  prompt: "In an agile team, developers have no involvement with testing once they finish coding.",
  success_message: "Correct! Developers handle unit tests and often assist in integration testing.",
  failure_message: "Not quite! Developers play a role in testing beyond just writing code.",
  correct_answer: false
}
create_true_false_step(course, "Developers Involvement in Testing", 33, true_false_dev_testing)

test_roles_ord_data = {
  prompt: "For our Iteration 3 payment feature testing, place the following communication flow steps in the correct order:",
  success_message: "Great job! You've correctly ordered the communication flow that would occur during payment feature testing in an agile environment.",
  failure_message: "That's not quite right. Consider how information typically flows in an agile team during testing activities.",
  items: [
    { content: "Developer Alex implements payment code and writes unit tests, marking the story as 'Ready for Testing' in JIRA", correct_position: 1 },
    { content: "Tester Maria performs API tests on the payment integration and finds an issue with declined transactions", correct_position: 2 },
    { content: "Maria logs the defect in JIRA and mentions it in the Slack channel, tagging Alex", correct_position: 3 },
    { content: "The issue is discussed briefly during the daily standup with Marcus (Delivery Lead) noting it as a potential impediment", correct_position: 4 },
    { content: "Alex fixes the issue and requests Maria to verify the fix, communicating through a JIRA comment", correct_position: 5 },
    { content: "Maria verifies the fix and updates Sarah (Product Owner) that the payment feature meets acceptance criteria", correct_position: 6 }
  ]
}
create_ordering_step(course, "Test Roles Communication Flow", 34, test_roles_ord_data)

scheduling_info_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <div class="mb-6 bg-amber-50 border-l-4 border-amber-400 p-4 rounded-r">
        <h3 class="font-bold text-amber-800 mb-2">Current Process Assessment</h3>
        <p class="text-amber-700 mb-0">For Iteration 3, our current test scheduling approach has revealed several inefficiencies that need to be addressed:</p>
    </div>
    <div class="bg-gray-50 rounded-lg p-6 border border-gray-200 shadow-sm mb-6">
        <h3 class="text-lg font-bold text-blue-700 mb-4">Existing Schedule Management Issues</h3>
        <div class="space-y-4">
            <div class="flex items-start">
                <div class="text-red-500 mr-3 mt-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                <div>
                    <p class="text-gray-700"><span class="font-medium">Static Documentation:</span> The team maintains a manually updated Excel document on a shared drive (<code class="bg-gray-100 px-1 py-0.5 rounded text-sm font-mono">\\shared\NSS\testing\iteration3-schedule.xlsx</code>)</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="text-red-500 mr-3 mt-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                <div>
                    <p class="text-gray-700"><span class="font-medium">Inconsistent Updates:</span> Team members update the document sporadically, leading to outdated information and confusion</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="text-red-500 mr-3 mt-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                <div>
                    <p class="text-gray-700"><span class="font-medium">Limited Visibility:</span> Testing activities are often delayed because the schedule isn't readily visible to all stakeholders</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="text-red-500 mr-3 mt-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                <div>
                    <p class="text-gray-700"><span class="font-medium">Change Management:</span> When plans change (as they often do in agile), the document isn't consistently updated to reflect current status</p>
                </div>
            </div>
            <div class="flex items-start">
                <div class="text-red-500 mr-3 mt-1">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                <div>
                    <p class="text-gray-700"><span class="font-medium">Coordination Issues:</span> The team frequently encounters missed dependencies and difficulty tracking overall progress within the sprint</p>
                </div>
            </div>
        </div>
    </div>
</div>
HTML
create_info_step(course, "Current Test Schedule Approach", 35, scheduling_info_content)

schedule_improvement_question = {
  prompt: "Which scheduling approach would be MOST appropriate for this agile team to adopt instead of their current static document approach?",
  success_message: "Correct! A sprint/Kanban board is ideal for agile teams as it provides real-time visibility of work items, allows for easy updates, and aligns with the iterative nature of agile development.",
  failure_message: "That's not the best choice for an agile team. Consider what would provide better visibility and flexibility for an iterative approach.",
  options: [
    { text: "A detailed Gantt chart for the entire project", correct: false, feedback: "Gantt charts are typically used in traditional/waterfall projects and don't easily accommodate the frequent changes in agile." },
    { text: "A sprint or Kanban board that visually tracks work items through various stages", correct: true, feedback: "This approach aligns well with agile practices, providing transparency and real-time updates on progress." },
    { text: "A comprehensive test plan document updated monthly", correct: false, feedback: "Monthly updates are too infrequent for two-week sprints, and document-based tracking lacks visibility." },
    { text: "A weekly status email sent to all team members", correct: false, feedback: "Email updates don't provide continuous visibility and can quickly become outdated in a fast-moving agile environment." }
  ]
}
create_multiple_choice_step(course, "Scheduling Improvement", 36, schedule_improvement_question)

conclusion_info_content = <<-HTML
<div class="max-w-4xl mx-auto p-6 bg-white text-gray-800 leading-relaxed font-sans">
    <div class="bg-blue-50 border-l-4 border-blue-500 p-5 rounded-r mb-8">
        <p class="text-lg font-medium text-blue-700">You've successfully completed this comprehensive exploration of ISO 29119-3 test planning!</p>
    </div>
    <h3 class="text-xl font-bold text-blue-700 mb-4">Key Knowledge Acquired</h3>
    <div class="space-y-5 mb-8">
        <p class="text-gray-700">Throughout this course, you've gained valuable insights into creating effective test plans aligned with the ISO 29119-3 standard. You've learned how to:</p>
        <ul class="space-y-2 list-disc ml-6 text-gray-700">
            <li><strong>Structure formal test documentation</strong> that meets international standards while maintaining practical utility</li>
            <li><strong>Adapt the ISO 29119-3 framework</strong> to different project contexts, from traditional waterfall to agile methodologies</li>
            <li><strong>Identify and document critical test plan components</strong> including test contexts, stakeholders, risks, and strategies</li>
            <li><strong>Schedule and allocate resources efficiently</strong> to testing activities within project constraints</li>
            <li><strong>Implement effective communication planning</strong> to ensure all stakeholders remain informed about test activities</li>
        </ul>
        <p class="text-gray-700">You've also worked through a realistic scenario to apply these concepts in practice, building a test plan for a subscription system within an agile environment.</p>
    </div>
    <h3 class="text-xl font-bold text-blue-700 mb-4">ISO 29119-3: A Flexible Framework</h3>
    <div class="space-y-4 mb-8">
        <p class="text-gray-700">The ISO 29119-3 standard is designed to be scalable and adaptable. You now understand that it provides:</p>
        <ul class="space-y-2 list-disc ml-6 text-gray-700">
            <li>A comprehensive yet flexible structure that can be tailored to projects of any size</li>
            <li>Clear documentation standards that facilitate communication among diverse stakeholders</li>
            <li>Guidelines that can be implemented fully for regulated industries or selectively for agile teams</li>
            <li>Templates that ensure critical testing aspects aren't overlooked during planning</li>
        </ul>
        <p class="text-gray-700">Most importantly, you've learned to view ISO 29119-3 not as a rigid checklist, but as a valuable framework to support effective testing practices while meeting compliance requirements.</p>
    </div>
    <h3 class="text-xl font-bold text-blue-700 mb-4">Next Steps in Your Journey</h3>
    <div class="space-y-4 mb-6">
        <p class="text-gray-700">To continue building your expertise with ISO 29119-3 test planning:</p>
        <ul class="space-y-2 list-disc ml-6 text-gray-700">
            <li>Review the official ISO/IEC/IEEE 29119-3 standard document for deeper understanding</li>
            <li>Practice creating test plans for different project types to strengthen your adaptability</li>
            <li>Explore other parts of the ISO 29119 family covering test processes, techniques, and keywords</li>
            <li>Share your knowledge with colleagues to improve organizational testing practices</li>
        </ul>
    </div>
    <div class="bg-green-50 border border-green-200 rounded-lg p-6 shadow-sm">
        <p class="text-lg font-medium text-green-800 mb-3">Your path to better testing starts now!</p>
        <p class="text-green-700">By mastering ISO 29119-3 test planning, you've equipped yourself with internationally recognized skills that will enhance testing efficacy, improve documentation, and ultimately lead to higher quality software delivery.</p>
        <p class="text-green-800 font-medium mt-3">We wish you continued success in your testing projects and professional growth!</p>
    </div>
</div>
HTML
create_info_step(course, "Congratulations on Completing the Course!", 36, conclusion_info_content)
