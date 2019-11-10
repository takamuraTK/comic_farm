# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :publisherName, presence: true
  validates :url, presence: true, format: /\A#{URI.regexp(%w[http https])}\z/
  validates :salesDate, presence: true
  validates :isbn, presence: true, length: { is: 13 }
  validates :image_url, format: /\A#{URI.regexp(%w[http https])}\z/
  validates :series, presence: true
  validates :salesint, presence: true

  has_many :subscribes, foreign_key: 'book_id', dependent: :destroy
  has_many :users, through: :subscribes

  has_many :reviews, foreign_key: 'book_id', dependent: :destroy
  has_many :reviewuser, through: :reviews, source: :user

  has_many :favorites, foreign_key: 'book_id', dependent: :destroy
  has_many :favusers, through: :favorites, source: :user

  belongs_to :bookseries, optional: true
end
