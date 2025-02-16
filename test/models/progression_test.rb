require "test_helper"

class ProgressionTest < ActiveSupport::TestCase
  test "sets initial step on creation" do
    course = create(:course)
    step1 = create(:step, course: course, position: 1)
    progression = create(:progression, course: course)
    assert_equal step1, progression.current_step
  end
end
