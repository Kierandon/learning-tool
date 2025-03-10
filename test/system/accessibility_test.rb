require "application_system_test_case"

class AccessibilityTest < ApplicationSystemTestCase
  setup do
    @standard = StandardLoader.load_from_yaml(Rails.root.join("db/seeds/courses/iso29119_standard.yml"))
    @course = CourseLoader.load_from_yaml(Rails.root.join("db/seeds/courses/iso29119_course.yml"))
  end

  test "homepage should be accessible" do
    visit root_url

    assert_accessible(page)
  end

  test "standard page should be accessible" do
    visit courses_standard_path(@standard)

    assert_accessible(page)
  end

  test "iso29119 course should be accessible" do
    user = User.create!
    visit new_session_path
    fill_in "login_hash", with: user.login_hash
    click_button "Login"
    assert_current_path root_path
    visit confirm_start_course_path(@course)

    @course.steps.each do |step|
      p "Visiting step: #{step.title}"
      visit course_step_path(@course, step)
      assert_accessible(page)
    end

    visit complete_course_path(@course)
    assert_accessible(page)
  end
end
