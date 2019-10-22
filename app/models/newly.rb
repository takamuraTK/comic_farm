class Newly < ApplicationRecord
    validates :publisherName, presence: true
    validates :counter, presence: true
    validates :month, presence: true
end
