class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :subscribes
  has_many :books, through: :subscribes
  
  
  def addsub(book)
	  subscribes.find_or_create_by!(book_id: book.id)
  end
  
  def removesub(book)
	  subscribe = subscribes.find_by(book_id: book.id)
	  subscribe.destroy if subscribe
  end
  
  def checksub?(comic)
    book = Book.find_by(isbn: comic)
    self.books.include?(book)
  end
  
  
  has_many :reviews
  has_many :reviewbook, through: :reviews, source: :books
end
