class StandardsListComponent < ViewComponent::Base
  attr_reader :standards

  def initialize(standards:, ordering: false)
    @standards = standards
  end
end
