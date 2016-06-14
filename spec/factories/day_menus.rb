# == Schema Information
#
# Table name: day_menus
#
#  id         :integer          not null, primary key
#  day_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :day_menu do
    day_id { DateTime.now.wday }
    items {
      create_list(:item, 3, menu: create(:menu)) + create_list(:item, 3, menu: create(:menu)) + create_list(:item, 3, menu: create(:menu))
    }
    created_at DateTime.now.beginning_of_day
  end
end
