# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :decimal(, )
#  menu_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_items_on_menu_id  (menu_id)
#
# Foreign Keys
#
#  fk_rails_6f9379e5f1  (menu_id => menus.id)
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'associations' do
    it { should belong_to(:menu) }
    it { should have_many(:item_associations).dependent(:destroy) }
  end

  context 'validations' do
    it { validate_presence_of :menu }

    it { validate_presence_of :name }
    it { validate_length_of(:name).is_at_least(1).is_at_most(100) }

    it { validate_presence_of :price }
  end
end
