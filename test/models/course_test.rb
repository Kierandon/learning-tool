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

    assert_equal first_progression, second_progression
  end
end
