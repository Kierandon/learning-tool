class CoursesListComponent < ViewComponent::Base
  def initialize(courses:)
    @courses = courses
  end
end
