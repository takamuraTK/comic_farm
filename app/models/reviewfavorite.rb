class Reviewfavorite < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :user_id, :uniqueness => {:scope => :review_id}
end
