# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    user
    book
    head { 'レビュータイトル' }
    content { 'この漫画は素晴らしい' }
    point { 4.6 }
  end
end
