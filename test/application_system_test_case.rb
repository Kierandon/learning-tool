require "test_helper"
require "axe/matchers/be_axe_clean"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def assert_accessible(page, matcher = Axe::Matchers::BeAxeClean.new.according_to(:wcag21aa, "best-practice"))
    audit_result = matcher.audit(page)
    assert(audit_result.passed?, audit_result.failure_message)
  end
end
