class Book < ApplicationRecord

  has_many :subscribes, foreign_key: 'book_id', dependent: :destroy
  has_many :users, through: :subscribes
  
end
