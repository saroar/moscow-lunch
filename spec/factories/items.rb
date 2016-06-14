# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  category_id :integer
#  name        :string
#  price       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryGirl.define do
  factory :item do
    name  { Faker::App.name }
    menu  { create :nemu }
    price { Faker::Number.between(30, 150) }
  end
end
