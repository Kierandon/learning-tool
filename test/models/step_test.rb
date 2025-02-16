require "test_helper"

class StepTest < ActiveSupport::TestCase
  test "previous_step returns the step with next lowest position" do
    course = create(:course)
    step1 = create(:step, course: course, position: 1)
    step2 = create(:step, course: course, position: 2)
    step3 = create(:step, course: course, position: 3)

    assert_equal step1, step2.previous_step
    assert_equal step2, step3.previous_step
    assert_nil step1.previous_step
  end

  test "next_step returns the step with next highest position" do
    course = create(:course)
    step1 = create(:step, course: course, position: 1)
    step2 = create(:step, course: course, position: 2)
    step3 = create(:step, course: course, position: 3)

    assert_equal step2, step1.next_step
    assert_equal step3, step2.next_step
    assert_nil step3.next_step
  end
end
