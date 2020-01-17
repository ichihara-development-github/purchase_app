# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Store.create(name:"Bike Shop",description:"あなたにぴったりの自転車が見つかるはず！休日は愛車とともに遠出しよう",category:"スポーツ",user_id: 1)
Store.create(name:"Cake Shop",description:"午後のひと時を彩りを！一度食べれば絶対にはまるケーキを販売",category:"食品",user_id:2)
Store.create(name:"Program Shop",description:"オリジナルのアプリを作ります！まずは一度ご覧ください！",category:"デジタル",user_id:3)
User.create(name:"user1", email: "user1@example.com", password: "password", introduce:"こんにちはuser1です。ここではbikeshopを運営させていただいてます！",store_id:1,seller: true, admin: true)
User.create(name:"user2", email: "user2@example.com", password: "password", introduce:"こんにちはuser2です。ここではcakeを運営させていただいてます！",store_id:2, seller: true)
User.create(name:"user3", email: "user3@example.com", password: "password",introduce:"こんにちはuse3です。ここではprogramshopを運営させていただいてます！",store_id:3, seller: true)

Production.create(name: "マウンテンバイク",description:"オフロードもすいすい進むマウンテンバイクです",price:45000,store_id:1)
Production.create(name: "ロードバイク",description:"スピード感が売りのロードバイクです",price:35000,store_id:1)
Production.create(name: "ママチャリ",description:"ママチャリです",price:25000,store_id:1)
Production.create(name: "ショートケーキ",description:"イチゴ付きのケーキです",price:2500,store_id:2)
Production.create(name: "モンブラン",description:"モンブラン",price:450,store_id:2)
Production.create(name: "診断アプリ",description:"診断アプリです",price:3500,store_id:3)
