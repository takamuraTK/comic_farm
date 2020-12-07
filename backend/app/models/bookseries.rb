# frozen_string_literal: true

class Bookseries < ApplicationRecord
  has_many :books
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :publisher, presence: true
end
