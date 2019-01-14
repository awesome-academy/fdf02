# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "anh",
              email: "ngokt100@gmail.com",
              password:              "123456",
              password_confirmation: "123456",
              phone: "121323123",
              role: 1)

User.create!(name:  "tuan",
              email: "tuan@gmail.com",
              password:              "123456",
              password_confirmation: "123456",
              phone: "121323123",
              role: 0)
30.times do |n|
  name = Faker::Name.name
  email = "mailer-#{n+2}example@gmail.com"
  password = "123456"
  phone = "09112132131"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              phone: phone,
              role: 0)
end

40.times do |n|
  name = Faker::Name.name
  parent_id = n % 2
  Category.create!(name: name, parent_id: parent_id)
end

40.times do |n|
  name = Faker::Name.name
  price = 50000
  user_id = 1
  category_id = 2
  description = "This is product #{name}"
  Product.create!(name: name,
                  price: price,
                  description: description,
                  user_id: user_id,
                  category_id: category_id)
end

products = Product.all
products.each { |product| product.images.create!(picture: "banh.png") }

