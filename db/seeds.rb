# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name:  "Example User",
#              email: "example@railstutorial.org",
#              password:              "foobar",
#              password_confirmation: "foobar",
#              admin: true)
#
no_of_users = 15
no_of_products = 15

no_of_users.times do |n|
  name  = Faker::Name.name
  email = "examples-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

no_of_products.times do |n|
  name = Faker::Commerce.product_name
  description = Faker::Lorem.sentence(5)
  price = Faker::Commerce.price
  Product.create!(name: name,
                  description: description,
                  price: price)
end

users = User.order(:created_at).take(no_of_users)
users.each do |user|
  10.times do |n|
    user.reviews.create!(
    content: Faker::Lorem.sentence(5),
    product_id: rand(1..no_of_products)
    )
  end
end
