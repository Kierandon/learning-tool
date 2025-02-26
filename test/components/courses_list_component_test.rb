require "test_helper"

class CoursesListComponentTest < ViewComponent::TestCase
  def setup
    @course1 = create(:course, title: "Course 1", description: "Description 1", image_url: "https://example.com/image1.jpg", ordering: 2)
    @course2 = create(:course, title: "Course 2", description: "Description 2", image_url: "https://placehold.co/600x400", ordering: 1)
  end

  def test_component_renders_courses
    render_inline(CoursesListComponent.new(courses: Course.all))

    assert_selector "div[data-test-id='courses-list-header']", text: "Available Courses"
    assert_selector "h3", text: "Course 1"
    assert_selector "p", text: "Description 1"
    assert_selector "h3", text: "Course 2"
    assert_selector "p", text: "Description 2"
  end

  def test_component_renders_courses_in_correct_order
    render_inline(CoursesListComponent.new(courses: Course.order(ordering: :asc)))

    assert_text(/Course 2.*Course 1/m)
  end
end
