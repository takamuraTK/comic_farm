# frozen_string_literal: true

FactoryBot.define do
  factory :reviewfavorite do
    user
    review
  end
end
