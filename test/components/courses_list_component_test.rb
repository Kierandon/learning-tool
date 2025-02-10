# frozen_string_literal: true

require "test_helper"
class CoursesListComponentTest < ViewComponent::TestCase
  def test_component_renders_courses
    render_inline(CoursesListComponent.new(courses: Course.all))

    assert_selector "div[data-test-id='courses-list-header']", text: "Available Courses"
    assert_selector "h2", text: "Course 1"
    assert_selector "p", text: "Description 1"
    assert_selector "img[src='https://example.com/image1.jpg']"
    assert_selector "h2", text: "Course 2"
    assert_selector "p", text: "Description 2"
    assert_selector "img[src='https://placehold.co/600x400']"
  end

  def test_component_renders_courses_in_correct_order
    render_inline(CoursesListComponent.new(courses: Course.all, ordering: true))

    assert_text (/Course 2.*Course 1/m)
  end
end
