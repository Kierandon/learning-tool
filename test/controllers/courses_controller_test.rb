require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = create(:course)
  end

  test "should show the selected course" do
    get course_path(@course)
    assert_response :success
  end
end
