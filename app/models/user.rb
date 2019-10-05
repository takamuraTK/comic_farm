class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :subscribes
  has_many :books, through: :subscribes
  
  has_many :favorites
  has_many :favbooks, through: :favorites, source: :book
  validates :profile, length: { maximum: 1000 }
  
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
  
  def addfav(book)
    favorites.find_or_create_by(book_id: book.id)
  end
  
  def removefav(book)
    favorite = favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
  end
  
  def checkfav?(book)
    self.favbooks.include?(book)
  end
  
  
  has_many :reviews
  has_many :reviewbook, through: :reviews, source: :book

  has_many :reviewfavorites
  has_many :favreviews, through: :reviewfavorites, source: :review
  
  def addreviewfav(review)
    reviewfavorites.find_or_create_by(review_id: review.id)
  end

  def removereviewfav(review)
    reviewfavorite = reviewfavorites.find_by(review_id: review.id)
    reviewfavorite.destroy if reviewfavorite
  end

  def checkreviewfav?(review)
    self.favreviews.include?(review)
  end


  mount_uploader :image, ImageUploader
end
