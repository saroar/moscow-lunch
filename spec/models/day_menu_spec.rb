# == Schema Information
#
# Table name: day_menus
#
#  id         :integer          not null, primary key
#  day_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DayMenu, type: :model do
  context 'associations' do
    it { should have_many(:item_associations).dependent(:destroy) }
    it { should have_many(:items).through(:item_associations) }
  end

  context 'validations' do
    it { should validate_presence_of :day_id }
    it { should validate_presence_of :items}
  end

  context '.actual' do
    before do
      @date = DateTime.now

      @today_day_id = @date.wday
      @another_day_id = (@date + 1.day).wday

      @day_menu_1 = FactoryGirl.create(:day_menu, day_id: @today_day_id, created_at: @date - 2.days )
      @day_menu_2 = FactoryGirl.create(:day_menu, day_id: @today_day_id, created_at: @date - 1.day )
      @day_menu_3 = FactoryGirl.create(:day_menu, day_id:@today_day_id, created_at: @date + 1.day )

      @day_menu_4 = FactoryGirl.create(:day_menu, day_id: @another_day_id, created_at: @date- 2.days )
      @day_menu_5 = FactoryGirl.create(:day_menu, day_id: @another_day_id, created_at: @date - 1.day )
    end

    it { expect(DayMenu.actual(@date)).to eq( @day_menu_2) }
    it { expect(DayMenu.actual(@date + 3.days)).to be_nil }
  end
end
