class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :item_associations, as: :item_association, dependent: :destroy
  has_many :items, through: :item_associations

  validates :user,  presence: true
  validates :items, presence: true
end
