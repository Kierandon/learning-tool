require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.find_by(login_hash: "123456")
  end

  test "should get new session form" do
    get new_session_path
    assert_response :success
  end

  test "should create session with valid login_hash" do
    post session_path, params: { session: { login_hash: @user.login_hash } }
    assert_equal @user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test "should not create session with invalid login_hash" do
    post session_path, params: { session: { login_hash: "invalid_hash" } }
    assert_nil session[:user_id]
    assert_response :success
    assert_template :new
  end

  test "should destroy session" do
    delete session_path
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end
end
