module ViewComponentUserHelper
  private

  def current_user
    helpers.current_user
  end
end

ViewComponent::Base.prepend(ViewComponentUserHelper)
