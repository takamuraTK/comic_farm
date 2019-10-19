FactoryBot.define do
  factory :user do
    name { "testuser" }
    sequence(:email) { |n| "hoge#{n}@example.com" }
    password { "hogehoge" }
    confirmed_at { Date.current.in_time_zone }
  end
end