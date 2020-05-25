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
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 image: open("#{Rails.root}/db/fixtures/img#{n}.jpg")
                )
  end

#ゲスト
User.create!(name: "ゲスト",
             email: "guestt@example.com",
             password: "password",
             password_confirmation: "password",
             image: open("#{Rails.root}/db/fixtures/guest.jpg")
            )

User.create!(name: "admin",
             email: "admin@sample.com",
             password: ENV['ADMIN_PASSWORD'],
             password_confirmation: ENV['ADMIN_PASSWORD'],
             admin: true)