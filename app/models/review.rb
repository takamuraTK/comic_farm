class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :head, presence: true
  validates :content, presence: true
  validates :point, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5,
  }
end
