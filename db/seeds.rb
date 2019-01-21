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
  address = "12#{n} Le Hong Phong"
  User.create!(name:  name,
              email: email,
              address: address,
              password:              password,
              password_confirmation: password,
              phone: phone,
              role: 0)
end

Category.create!(name: "trasua", parent_id: 1)
Category.create!(name: "caphe", parent_id: 2)
Category.create!(name: "banh", parent_id: 3)

10.times do |n|
  name = "trasua #{n}"
  price = 10000 + n
  user_id = 1
  description = "This is product #{name}"
  Product.create!(name: name,
                  price: price,
                  description: description,
                  user_id: user_id,
                  category_id: 1)
end

for n in 1..10
  name = "caphe #{n}"
  price = 50000
  user_id = 2
  description = "This is product #{name}"
  Product.create!(name: name,
                  price: price,
                  description: description,
                  user_id: user_id,
                  category_id: 2)
end

for n in 1..10
  name = "banh #{n}"
  price = 50000
  user_id = 3
  description = "This is product #{name}"
  Product.create!(name: name,
                  price: price,
                  description: description,
                  user_id: user_id,
                  category_id: 3)
end

40.times do |n|
  name = Faker::Name.name
  phone = "09112132131"
  address = "12#{n} Le Hong Phong"
  Order.create!(user_id: 1,
                customer_name: name,
                customer_address: address,
                customer_phone: phone)
end

products = Product.select_cate_product(1)
products.each { |product| product.images.create!(picture: "trasua.jpg") }

products = Product.select_cate_product(2)
products.each { |product| product.images.create!(picture: "caphe.jpeg") }

products = Product.select_cate_product(3)
products.each { |product| product.images.create!(picture: "banh.png") }

users = User.all
users.each { |user| user.orders.create!(status: 0)}
users.each do |user|
  for n in 1..10
    user.suggests.create!(content: "This my suggest #{n}",status: 0)
  end
end
