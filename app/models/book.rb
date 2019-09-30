class Book < ApplicationRecord

  has_many :subscribes, foreign_key: 'book_id', dependent: :destroy
  has_many :users, through: :subscribes
  
  has_many :reviews, foreign_key: "book_id", dependent: :destroy
  has_many :reviewuser, through: :reviews, source: :user
  
  has_many :favorites, foreign_key: 'book_id', dependent: :destroy
  has_many :favusers, through: :favorites, source: :user

  belongs_to :bookseries, optional: true
  
end
