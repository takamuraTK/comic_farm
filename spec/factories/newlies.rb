# frozen_string_literal: true

FactoryBot.define do
  factory :newly do
    publisherName { '集英社' }
    counter { 123 }
    month { Time.current }
  end
end
