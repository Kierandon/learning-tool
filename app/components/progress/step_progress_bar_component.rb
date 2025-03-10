module Progress
  class StepProgressBarComponent < ViewComponent::Base
    def initialize(course:, current_step:, user:)
      @course = course
      @current_step = current_step
      @user = user
      @progression = course.progressions.find_by(user: user) if user
      @total_steps = course.steps.count
      @current_step_position = current_step.position || 0
      @progress_percentage = progress_percentage || 0
      @steps_completed = @progression&.steps_completed_count || 0
    end

    def progress_percentage
      # For a course with 5 steps, we start at 0% end at 100%, this means, we have 4 gaps, so we do
      # 100 / 4 = 25, so each step is worth 25%.
      if @total_steps <= 1
        return @current_step_position > 0 ? 100 : 0
      end

      gap_percentage = 100.0 / (@total_steps - 1)
      completed_percentage = (@current_step_position - 1) * gap_percentage

      [ 0, completed_percentage, 100 ].sort[1].round
    end

    def completion_percentage
      return 0 if @total_steps == 0

      completed = @current_step_position - 1
      percentage = (completed.to_f / @total_steps) * 100

      [ 0, percentage, 100 ].sort[1].round
    end

    def completed_steps
      @steps_completed
    end

    def total_steps
      @total_steps
    end

    def all_steps
      @course.steps.order(:position)
    end

    def get_step_status(step)
      if step.position < @current_step&.position
        "completed"
      elsif step.position == @current_step&.position
        "current"
      else
        "upcoming"
      end
    end
  end
end
