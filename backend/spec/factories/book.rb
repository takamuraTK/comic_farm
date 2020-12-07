# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'hogehoge (32)' }
    author { '田中 太郎' }
    publisherName { '講談社' }
    url { 'https://books.rakuten.co.jp/rb/0000000' }
    salesDate { '2000年11月11日' }
    isbn { '1111111111111' }
    image_url { 'https://books.rakuten.co.jp/rb/0000000.jpg' }
    series { 'hogehoge' }
    salesint { 20_001_111 }
  end
end
