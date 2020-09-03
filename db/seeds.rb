# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "User 1", email: "user1@camerastore.com", password: "Password12", password_confirmation: "Password12")
User.create(name: "User 2", email: "user2@camerastore.com", password: "Password34", password_confirmation: "Password34")

(1..10).each do |i|
  Product.create({
    name: "Product #{i}",
    description: "Product description #{i}",
    price: (i * 100),
    make: (2000 + i)
  })
end
