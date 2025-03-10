require "application_system_test_case"

class AccessibilityTest < ApplicationSystemTestCase
  setup do
    StandardLoader.load_from_yaml(Rails.root.join("db/seeds/courses/iso29119_standard.yml"))
    CourseLoader.load_from_yaml(Rails.root.join("db/seeds/courses/iso29119_course.yml"))
  end

  test "homepage should be accessible" do
    visit root_url

    assert_accessible(page)
  end

  test "standard page should be accessible" do
    visit courses_standard_path(Standard.first)

    assert_accessible(page)
  end

  test "course page should be accessible" do
    visit course_path(Course.first)

    assert_accessible(page)
  end
end
