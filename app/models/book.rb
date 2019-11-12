# frozen_string_literal: true

class Book < ApplicationRecord
  before_save :set_series
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

  def count_subs
    count = Book.joins(:subscribes).group(:book_id).count[id]
    count ||= 0
  end

  def count_favs
    count = Book.joins(:favorites).group(:book_id).count[id]
    count ||= 0
  end

  private
  def set_series
    if Bookseries.find_by(title: self.series).nil?
      bookseries = Bookseries.new(title: self.series)
      bookseries.save
    end
  end
end
