# frozen_string_literal: true

require "test_helper"

class FooterComponentTest < ViewComponent::TestCase
  def test_component_renders_footer
    render_inline(FooterComponent.new)

    assert_selector "a", text: "Help"
  end

  def test_renders_login_hash_when_logged_in
    @user = create(:user)
    render_inline(FooterComponent.new(current_user: @user))

    assert_selector "p", text: @user.login_hash
  end
end
