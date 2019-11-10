# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8

User.create(name: 'TestUser', email: 'xxx@example.com', password: 'password', confirmed_at: Date.current.in_time_zone, admin: true)
Book.create(title: 'ブルーピリオド（2）', author: '山口 つばさ', publisherName: '講談社', url: 'https://books.rakuten.co.jp/rb/15371858/', salesDate: '2018年03月23日', isbn: '9784065111246', image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1246/9784065111246.jpg?_ex=350x350', series: 'ブルーピリオド', salesint: 20_180_323)
Subscribe.create(user_id: 1, book_id: 1)

(1..20).each do |number|
  User.create(
    name: 'SampleUser' + number.to_s,
    email: 'sampleuser' + number.to_s + '@example.com',
    password: 'password',
    confirmed_at: Date.current.in_time_zone
  )
  Review.create(user_id: number + 1, book_id: 1, head: 'タイトル' + number.to_s, content: 'ここにレビュー内容が表示されます', point: 5.0)
end
