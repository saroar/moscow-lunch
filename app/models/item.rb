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

class Item < ActiveRecord::Base
  belongs_to :menu
  has_many :item_associations, dependent: :destroy

  validates :menu,  presence: true
  validates :name,  presence: true
  validates :price, presence: true, numericality: { greather_than: 5 }
end
