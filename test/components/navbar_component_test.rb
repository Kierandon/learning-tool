# frozen_string_literal: true

require "test_helper"

class NavbarComponentTest < ViewComponent::TestCase
  def test_component_renders_navbar
    render_inline(NavbarComponent.new)

    assert_selector "nav"
    assert_selector "div[data-testid='navbar-title']", text: "Learning Tool"
  end
end
