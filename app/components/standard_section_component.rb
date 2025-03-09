class StandardSectionComponent < ViewComponent::Base
  def initialize(section:, level: 0, user: nil)
    @section = section
    @level = level
    @user = user
  end

  def completion_percentage
    return 0 if @user.nil?
    @section.completion_percentage_for(@user)
  end
end
