FactoryBot.define do
  factory :user do
    name { "testuser" }
    email { "hogehoge@example.com" }
    password { "hogehoge" }
    confirmed_at { Date.current.in_time_zone }
  end
end