# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
rabbix = Group.create(initial: 'rabbix', name: 'ラビックス', email: 'fujioka@rabbix.net')
fujioka = User.create(name: '藤岡', email: 'fujioka@rabbix.net', group: rabbix)
10.times do |n|
  rabbix.articles << Article.new(title: "タイトル#{n}", comment: "テスト:#{n}", user: fujioka, name: '藤岡')
end

