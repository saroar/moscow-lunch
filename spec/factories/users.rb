FactoryGirl.define do
  factory :user do
    name                    { Faker::Name.name }
    organization            { create :organization }
    email                   { Faker::Internet.email }
    password                "password"
    password_confirmation   "password"
  end
end
