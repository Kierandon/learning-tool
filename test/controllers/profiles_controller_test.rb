require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @user = create(:user)
  end

  test "should show profile when user is signed in" do
    sign_in @user
    get profile_url
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  test "should redirect to root when user is not signed in" do
    get profile_url
    assert_redirected_to root_path
  end
end
