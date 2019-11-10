# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :head, presence: true, length: { in: 1..20 }
  validates :content, presence: true, length: { in: 1..2000 }
  validates :point, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
  validates :user_id, uniqueness: { scope: :book_id }
  has_many :reviewfavorites, foreign_key: 'review_id', dependent: :destroy
  has_many :users, through: :reviewfavorites
end
