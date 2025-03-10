require "test_helper"

class CoursesListComponentTest < ViewComponent::TestCase
  def setup
    @courses = create_list(:course, 3)
  end

  def test_component_renders_courses
    render_inline(Courses::CoursesListComponent.new(courses: @courses))

    assert_selector ".border.rounded-lg", count: 3
  end

  def test_component_renders_courses_in_correct_order
    ordered_courses = [
      create(:course, title: "Course 3", ordering: 3),
      create(:course, title: "Course 1", ordering: 1),
      create(:course, title: "Course 2", ordering: 2)
    ]

    render_inline(Courses::CoursesListComponent.new(courses: ordered_courses, ordering: true))

    titles = page.all(".font-semibold.text-lg").map(&:text)
    assert_equal [ "Course 1", "Course 2", "Course 3" ], titles
  end
end
