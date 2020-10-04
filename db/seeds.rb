# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :en

12.times do |n|
    name  = Faker::Name.name
    email = "sample#{n+1}@sample.com"
    password = "password"
    User.create!(name:  name,
                 profile: "#{name}です。たくさんおいしい料理を共有したいです。よろしくお願いします！！",
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 image: open("#{Rails.root}/db/fixtures/img#{n}.jpg")
                )
end

#ゲスト
User.create!(name: "ゲスト",
             profile: "ゲストユーザーです。このサイトを楽しんでいってください！",
             email: "guestt@example.com",
             password: "password",
             password_confirmation: "password",
             image: open("#{Rails.root}/db/fixtures/guest.jpg")
            )

User.create!(name: "admin",
             profile: "管理人です。",
             email: "admin@sample.com",
             password: ENV['ADMIN_PASSWORD'],
             password_confirmation: ENV['ADMIN_PASSWORD'],
             admin: true)

users = User.order(:created_at)
3.times do |n|
  content = ["めっちゃ美味しかった！！","おすすめです！！","三ツ星　進呈レベル！"]
  tags = ["フレンチ","イタリアン","アイス"]
  users[0].microposts.create!(content: content[n],
                              tag_list: tags[n],
                              picture: open("#{Rails.root}/db/fixtures/foods#{n}.jpg"))
end
3.times do |n|
  content = ["リピ確定！！","最＆高！！","風味がたまりません！！"]
  tags = ["イタリアン","BAR","イタリアン"]
  users[1].microposts.create!(content: content[n],
                              tag_list: tags[n],
                              picture: open("#{Rails.root}/db/fixtures/foods#{n+3}.jpg"))
end
7.times do |n|
  content = ["すごく美味しい！毎月食べる！","美味しすぎてびっくりドンキー！","うーん。いいねぇ～。","エクセレント！","メキシカン！！　スパイシーで美味しい！",
             "はじめての味！！　おいし～い","おしゃんなコーヒー"]
  tags = ["まったり","ホタテ","お洒落","バーガー","タコス","お洒落","お洒落"]
  users[2].microposts.create!(content: content[n],
                              tag_list: tags[n],
                              picture: open("#{Rails.root}/db/fixtures/foods#{n+6}.jpg"))
end
#ゲストの投稿
3.times do |n|
  content = ["まいう～！！","ガッツリいっちゃいます！！","朝からまったり。"]
  tags = ["寿司","牛肉","モーニング"]
  users[12].microposts.create!(content: content[n],
                              tag_list: tags[n],
                              picture: open("#{Rails.root}/db/fixtures/foods#{n+13}.jpg"))
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..13]
followers = users[3..13]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }