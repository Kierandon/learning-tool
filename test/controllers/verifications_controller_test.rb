require "test_helper"

class VerificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @standard = create(:standard)
    @certificate = create(:standard_certificate, user: @user, standard: @standard)
  end

  test "should show valid certificate" do
    get verify_certificate_url(certificate_number: @certificate.certificate_number)
    assert_response :success
    assert_equal "valid", assigns(:verification_status)
    assert_equal @standard, assigns(:standard)
    assert_equal @user, assigns(:user)
    assert_not_nil assigns(:completed_learning_objectives)
  end

  test "should show invalid status for non-existent certificate" do
    get verify_certificate_url(certificate_number: "non-existent-number")
    assert_response :success
    assert_equal "invalid", assigns(:verification_status)
    assert_nil assigns(:standard)
    assert_nil assigns(:user)
    assert_nil assigns(:completed_learning_objectives)
  end
end
