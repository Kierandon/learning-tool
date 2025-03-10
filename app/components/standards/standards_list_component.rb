module Standards
  class StandardsListComponent < ViewComponent::Base
    attr_reader :standards

    def initialize(standards:)
      @standards = standards
    end
  end
end
