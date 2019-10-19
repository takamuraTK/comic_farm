class Bookseries < ApplicationRecord
    has_many :books
    validates :title, presence: true
    validates :title, uniqueness: true
end
