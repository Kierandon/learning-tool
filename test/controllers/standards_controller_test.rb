require "test_helper"

class StandardsControllerTest < ActionDispatch::IntegrationTest
  include AuthenticationHelper

  setup do
    @user = create(:user)
    @standard = create(:standard)
    sign_in @user
  end

  test "should get index" do
    get standards_url
    assert_response :success
    assert_not_nil assigns(:standards)
  end

  test "should get courses" do
    get courses_standard_url(@standard)
    assert_response :success
    assert_equal @standard, assigns(:standard)
  end

  test "should generate certificate when completion is 100%" do
    Standard.any_instance.stubs(:completion_percentage).returns(100)

    assert_difference "StandardCertificate.count" do
      post generate_certificate_standard_url(@standard)
    end

    assert_redirected_to certificate_standard_url(@standard)
  end

  test "should not generate certificate when completion is less than 100%" do
    Standard.any_instance.stubs(:completion_percentage).returns(50)

    assert_no_difference "StandardCertificate.count" do
      post generate_certificate_standard_url(@standard)
    end

    assert_redirected_to courses_standard_url(@standard)
    assert_equal "You must complete 100% of the standard to generate a certificate.", flash[:alert]
  end

  test "should show certificate when it exists" do
    certificate = create(:standard_certificate, user: @user, standard: @standard)

    get certificate_standard_url(@standard)
    assert_response :success
    assert_equal certificate, assigns(:certificate)
    assert_not_nil assigns(:completed_learning_objectives)
  end

  test "should redirect to courses when certificate doesn't exist" do
    get certificate_standard_url(@standard)
    assert_redirected_to courses_standard_url(@standard)
    assert_equal "No certificate found. Please complete the standard first.", flash[:alert]
  end

  test "should set standard" do
    get courses_standard_url(@standard)
    assert_equal @standard, assigns(:standard)
  end
end
