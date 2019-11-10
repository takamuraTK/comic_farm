# frozen_string_literal: true

FactoryBot.define do
  factory :subscribe do
    user
    book
  end
end
