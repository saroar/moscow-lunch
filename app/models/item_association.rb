class ItemAssociation < ActiveRecord::Base
  belongs_to :item
  belongs_to :item_association, polymorphic: true
end
