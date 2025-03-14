require "test_helper"

class StepsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @standard = create(:standard)
    @course = create(:course, standard: @standard)
    @step = create(:step, course: @course)
    @progression = create(:progression, user: @user, course: @course)

    sign_in(@user)
  end

  test "should get show" do
    get course_step_path(@course, @step)
    assert_response :success
  end
end
