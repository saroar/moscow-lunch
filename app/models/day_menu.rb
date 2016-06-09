class DayMenu < ActiveRecord::Base
  has_many :item_associations, as: :item_association, dependent: :destroy
  has_many :items, through: :item_associations

  validates :day_id, presence: true, numericality: true
  validates :items, presence: true
end
