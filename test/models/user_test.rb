require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "creating a new user creates a valid login number" do
    user = create(:user)
    assert user.login_hash
    assert user.login_hash < "999999"
  end

  test "creating two distinct users automatically assigns unique login numbers" do
    user1 = create(:user)
    user2 = create(:user)
    assert_not_equal user1.login_hash, user2.login_hash
  end

  test "forcibly creating two users with the same login number raises an error when callback is skipped" do
    User.skip_callback(:create, :before, :generate_login_hash)
    user1 = User.new(login_hash: 123456)
    user2 = User.new(login_hash: 123456)

    assert user1.save
    assert_raises(ActiveRecord::RecordInvalid) { user2.save! }
  ensure
    User.set_callback(:create, :before, :generate_login_hash)
  end
end
