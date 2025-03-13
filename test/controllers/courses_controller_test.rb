require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @standard = create(:standard)
    @course = create(:course, standard: @standard)
    @user = create(:user)
    @step = create(:step, course: @course)
  end

  test "should show the selected course" do
    get course_path(@course)
    assert_response :success
  end

  test "should show course with progression for signed in user" do
    sign_in(@user)
    @progression = create(:progression, user: @user, course: @course)

    get course_path(@course)
    assert_response :success
    assert_not_nil assigns(:progression)
  end

  test "should start course for signed in user" do
    sign_in(@user)

    post start_course_path(@course)
    assert_response :redirect

    # Verify progression was created
    progression = @user.progressions.find_by(course: @course)
    assert_not_nil progression
    assert_redirected_to course_step_path(@course, progression.current_step)
  end

  test "should start course for anonymous user" do
    assert_difference "User.count", 1 do
      post start_course_path(@course)
    end

    assert_response :redirect

    # Verify new user was created and progression exists
    new_user = User.last
    progression = new_user.progressions.find_by(course: @course)
    assert_not_nil progression
    assert_equal session[:user_id], new_user.id
    assert_redirected_to course_step_path(@course, progression.current_step)
  end
end
