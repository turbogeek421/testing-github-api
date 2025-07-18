# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    number { Faker::Number.unique.between(from: 1, to: 10_000) }
    title { Faker::Book.title }
    state { "open" }
    body { Faker::Lorem.paragraph }

    trait :assigned do
      association :user
    end
  end
end
