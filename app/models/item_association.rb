class ItemAssociation < ActiveRecord::Base
  before_create :set_price

  belongs_to :item
  belongs_to :item_association, polymorphic: true

  def set_price
    self.price = item.price
  end
end
