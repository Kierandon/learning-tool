class CoursesListComponent < ViewComponent::Base
  def initialize(courses:, ordering: false)
    @courses = ordering ? courses.sort_by(&:ordering) : courses
  end
end
