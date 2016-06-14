# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :menu do
    name { Faker::Lorem.words(rand(2..3)) }
  end
end
