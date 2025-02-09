require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Next tests could be flaky due to fixtures, so let's delete all users before running it
  test "creating a new user creates a valid login number" do
    user = User.create
    assert user.login_hash
    assert user.login_hash < "999999"
  end

  test "forcibly creating two users with the same login number raises an error" do
    assert_raises ActiveRecord::RecordInvalid do
      User.create!(login_hash: 123456)
    end
  end
end
