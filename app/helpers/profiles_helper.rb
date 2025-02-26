module ProfilesHelper
end
module ProfilesHelper
  def display_course_badge(course, user)
    badge = course.badge

    if badge && user.badges.include?(badge)
      return badge
    end

    nil
  end
end
