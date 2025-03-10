if !Rails.env.production?
  Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |file|
    puts file
    require file
  end
end

# Achievements
[
  {
    name: "Question Master",
    description: "Answer 50 questions correctly",
    achievement_type: "question_count",
    threshold: 50,
    icon_identifier: "question_master"
  },
  {
    name: "Week Warrior",
    description: "Answer questions on 7 consecutive days",
    achievement_type: "streak",
    threshold: 7,
    icon_identifier: "week_warrior"
  }
].each do |achievement_data|
  achievement = Achievement.find_or_create_by!(
    name: achievement_data[:name]
  ) do |a|
    a.description = achievement_data[:description]
    a.achievement_type = achievement_data[:achievement_type]
    a.threshold = achievement_data[:threshold]
    a.icon_identifier = achievement_data[:icon_identifier]
  end
end

def create_test_standard
  test_standard = Standard.find_or_create_by!(code: "test_standard") do |s|
    s.name = "Test Standard for Demo"
    s.description = "A sample standard used for demonstration purposes."
    s.visibility = true
    puts "Test standard created: #{s.name}"
  end

  unless test_standard.sections.exists?
    parent_section = StandardSection.create!(
      standard: test_standard,
      name: "1. Introduction to Testing",
      section_id: "1",
    )

    child_sections = [
      { name: "1.1 Testing Fundamentals"  },
      { name: "1.2 Testing Lifecycle" },
      { name: "1.3 Testing Documentation" }
    ]

    child_sections.each do |section_data|
      StandardSection.create!(
        name: section_data[:name],
        standard: test_standard,
        section_id: section_data[:name].split('.').last.strip,
        parent_section: parent_section
      )
    end
  end

  test_standard
end

def create_sample_certificate
  demo_user = User.find_or_create_by!(login_hash: "demo_user") do |u|
    puts "Created demo user"
  end
  test_standard = create_test_standard
  sample_certificate = StandardCertificate.find_or_create_by!(
    certificate_number: "SAMPLE-CERT-2025"
  ) do |cert|
    cert.user = demo_user
    cert.standard = test_standard
    cert.issue_date = Date.new(2025, 1, 15)
    cert.competency_level = "Advanced"
    puts "Sample certificate created: #{cert.certificate_number}"
  end

  sample_certificate
end

create_sample_certificate
