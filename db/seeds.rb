# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name:"user1", email: "user1@example.com", password: "password", introduce:"こんにちはuser1です。ここではbikeshopを運営させていただいてます！",store_id:1,seller: true, admin: true)
User.create(name:"user2", email: "user2@example.com", password: "password", introduce:"こんにちはuser2です。ここではcakeを運営させていただいてます！",store_id:2, seller: true)
User.create(name:"user3", email: "user3@example.com", password: "password",introduce:"こんにちはuse3です。ここではprogramshopを運営させていただいてます！",store_id:3, seller: true)
