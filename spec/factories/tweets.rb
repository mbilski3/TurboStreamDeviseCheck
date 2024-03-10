# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    sequence(:content) { |n| "This is my tweet no #{n}." }
    user
  end
end
