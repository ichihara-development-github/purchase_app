# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name:"admin1", email: "admin1@user.com", password: "password", introduce:"こんにちは管理者１です",seller: true, admin: true)
User.create(name:"admin2", mail: "admin2@user.com", password: "password", introduce:"こんにちは管理者２です。", admin: true, seller: true)
