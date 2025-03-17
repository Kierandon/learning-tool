require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = create(:course)
    @user = create(:user)
  end

  test "start should create new progression for new user" do
    progression = @course.start(@user)

    assert progression.persisted?
    assert_equal @user, progression.user
    assert_equal @course, progression.course
  end

  test "start should return existing progression for existing user" do
    first_progression = @course.start(@user)
    second_progression = @course.start(@user)

    assert_equal first_progression.user_id, second_progression.user_id
    assert_equal first_progression.course_id, second_progression.course_id
    assert_nil second_progression.current_step_id
    assert_nil second_progression.completed_at
  end
end
