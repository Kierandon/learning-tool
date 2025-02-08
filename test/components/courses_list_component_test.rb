# frozen_string_literal: true

require "test_helper"

class CoursesListComponentTest < ViewComponent::TestCase
  def test_component_renders_courses
    courses = [
      Course.new(title: "Course 1", description: "Description 1", image_url: "https://example.com/image1.jpg"),
      Course.new(title: "Course 2", description: "Description 2", image_url: nil)
    ]

    render_inline(CoursesListComponent.new(courses: courses))

    assert_selector "div[data-test-id='courses-list-header']", text: "Available Courses"
    assert_selector "h2", text: "Course 1"
    assert_selector "p", text: "Description 1"
    assert_selector "img[src='https://example.com/image1.jpg']"
    assert_selector "h2", text: "Course 2"
    assert_selector "p", text: "Description 2"
    assert_selector "img[src='https://placehold.co/600x400']"
  end
end
