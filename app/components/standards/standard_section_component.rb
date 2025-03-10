module Standards
  class StandardSectionComponent < ViewComponent::Base
    attr_reader :section, :level, :user

    def initialize(section:, level:, user:)
      @section = section
      @level = level
      @user = user
    end

    def completion_percentage
      return 0 if @user.nil?
      @section.completion_percentage_for(@user)
    end
  end
end
