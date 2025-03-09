class StandardSectionComponent < ViewComponent::Base
  def initialize(section:, level: 0, user: nil)
    @section = section
    @level = level
    @user = user
  end

  def completion_percentage
    return 0 if @user.nil?

    # Count direct learning objectives in this section
    total_direct_lo = @section.learning_objectives.count
    completed_direct_lo = @section.learning_objectives.count { |lo| lo.completed_by?(@user) }
    direct_percentage = total_direct_lo > 0 ? (completed_direct_lo.to_f / total_direct_lo * 100) : 0

    # If there are subsections, include their completion in the calculation
    if @section.subsections.any?
      # Get subsection data
      subsection_data = @section.subsections.map do |subsection|
        component = StandardSectionComponent.new(
          section: subsection,
          level: @level + 1,
          user: @user
        )

        # Get the completion percentage and learning objective count for this subsection
        {
          percentage: component.completion_percentage,
          lo_count: subsection.learning_objectives.count + subsection.subsections.sum { |s| recursive_lo_count(s) }
        }
      end

      # Calculate weighted average
      total_subsection_lo = subsection_data.sum { |data| data[:lo_count] }
      total_lo = total_direct_lo + total_subsection_lo

      if total_lo > 0
        # Calculate weights
        direct_weight = total_direct_lo.to_f / total_lo
        subsection_weight = total_subsection_lo.to_f / total_lo

        # Calculate weighted sum
        weighted_direct = direct_percentage * direct_weight
        weighted_subsections = subsection_data.sum do |data|
          data[:lo_count].to_f / total_subsection_lo * data[:percentage]
        end * subsection_weight

        # Return weighted average
        return weighted_direct + (total_subsection_lo > 0 ? weighted_subsections : 0)
      end
    end

    direct_percentage
  end

  private

  def recursive_lo_count(section)
    direct_count = section.learning_objectives.count
    subsection_count = section.subsections.sum { |s| recursive_lo_count(s) }
    direct_count + subsection_count
  end
end
