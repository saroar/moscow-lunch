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

class ItemSerializer < ActiveModel::Serializer
  attributes :name, :price

  has_one :menu
end
