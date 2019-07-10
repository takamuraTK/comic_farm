class Book < ApplicationRecord

  has_many :subscribes, foreign_key: 'book_id', dependent: :destroy
  has_many :users, through: :subscribes
  
  has_many :reviews, foreign_key: "book_id", dependent: :destroy
  has_many :reviewuser, through: :review, source: :users
  
end
