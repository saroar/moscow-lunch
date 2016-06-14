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

class Item < ActiveRecord::Base
  belongs_to :menu
  has_many :item_associations, dependent: :destroy

  validates :menu,  presence: true
  validates :name,  presence: true
  validates :price, presence: true, numericality: { greather_than: 5 }
end
