# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 
User.destroy_all
u1 = User.create :name => 'Craigsy', :email => 'craigsy@ga.co', :password => 'chicken'
u2 = User.create :name => 'Jonesy', :email => 'jonesy@ga.co', :password => 'chicken'
9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@ga.co"
  password = "chicken"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
  end
puts "#{ User.count } users"

Post.destroy_all
users = User.order(:created_at).take(6)
9.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..5]
followers = users[3..4]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
