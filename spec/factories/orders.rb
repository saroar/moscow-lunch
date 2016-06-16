# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  total           :decimal(, )
#  organization_id :integer
#
FactoryGirl.define do
  factory :order do
    user { create :user }

    after(:build) do |user|
      if user.items.empty?
        day_menu_items = create(:day_menu, day_id: DateTime.now.wday).items
        user.items << [day_menu_items[0], day_menu_items[3], day_menu_items[6]]
      end
    end
  end
end
