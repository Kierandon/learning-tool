ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest"

module AuthenticationHelper
  def sign_in(user)
    post session_path, params: {
      session: {
        login_hash: user.login_hash
      }
    }
    follow_redirect!
  end
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include AuthenticationHelper

  parallelize(workers: :number_of_processors)
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelper
end

class ViewComponent::TestCase
  def sign_in(user)
    ViewComponent::Base.any_instance.stubs(:current_user).returns(user)
  end
end
