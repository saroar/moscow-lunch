class Item < ActiveRecord::Base
  belongs_to :menu
  has_many :item_associations, dependent: :destroy

  validates :menu,  presence: true
  validates :name,  presence: true
  validates :price, presence: true, numericality: { greather_than: 5 }
end
