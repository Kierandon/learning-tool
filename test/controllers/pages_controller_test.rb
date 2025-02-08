require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "div[data-test-id='courses-list-header']", "Available Courses"
  end
end
