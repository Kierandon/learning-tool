Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |file|
  puts file
  require file
end
