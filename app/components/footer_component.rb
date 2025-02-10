# frozen_string_literal: true

class FooterComponent < ViewComponent::Base
  def initialize(current_user: nil)
    @current_user = current_user
  end
end
