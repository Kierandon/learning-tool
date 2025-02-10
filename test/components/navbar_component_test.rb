# frozen_string_literal: true

require "test_helper"

class NavbarComponentTest < ViewComponent::TestCase
  def test_component_renders_navbar
    render_inline(NavbarComponent.new)

    assert_selector "nav"
    assert_selector "div[data-testid='navbar-title']", text: "Learning Tool"
  end

  def test_renders_login_link_when_not_logged_in
    render_inline(NavbarComponent.new(current_user: nil))

    assert_selector "a.btn", text: "Login"
  end

  def test_renders_logout_link_when_logged_in
    render_inline(NavbarComponent.new(current_user: User.first))

    assert_selector "a", text: "Logout"
  end
end
