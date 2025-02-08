# frozen_string_literal: true

require "test_helper"

class FooterComponentTest < ViewComponent::TestCase
  def test_component_renders_footer
    render_inline(FooterComponent.new)

    assert_selector "a", text: "Help"
  end
end
