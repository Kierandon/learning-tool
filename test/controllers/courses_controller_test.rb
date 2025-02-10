require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should show the selected course" do
    get course_path(Course.first)
    assert_response :success
  end
end
