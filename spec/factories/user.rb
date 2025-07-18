# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login { Faker::Internet.unique.username }
    avatar_url { Faker::Internet.url }
    type { "User" }
    url { Faker::Internet.url }
  end
end
