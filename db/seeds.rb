Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |file|
  puts file
  require file
end

# Achievements
[
  {
    name: "Question Master",
    description: "Answer 50 questions correctly",
    achievement_type: "question_count",
    threshold: 50,
    icon_identifier: "question_master"
  },
  {
    name: "Week Warrior",
    description: "Answer questions on 7 consecutive days",
    achievement_type: "streak",
    threshold: 7,
    icon_identifier: "week_warrior"
  }
].each do |achievement_data|
  achievement = Achievement.find_or_create_by!(
    name: achievement_data[:name]
  ) do |a|
    a.description = achievement_data[:description]
    a.achievement_type = achievement_data[:achievement_type]
    a.threshold = achievement_data[:threshold]
    a.icon_identifier = achievement_data[:icon_identifier]
  end
end
