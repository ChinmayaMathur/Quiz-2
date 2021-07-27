FactoryBot.define do
  created_at = Faker::Date.backward(days:365 * 5)
  factory :idea do
    sequence(:title) {|n| Faker::Hacker.say_something_smart + " #{n}"}
    description {Faker::ChuckNorris.fact}
    created_at {created_at}
    updated_at {created_at}
    association(:user, factory: :user)
  end
end
