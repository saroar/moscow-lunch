# == Schema Information
#
# Table name: day_menus
#
#  id         :integer          not null, primary key
#  day_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DayMenu < ActiveRecord::Base
  has_many :item_associations, as: :item_association, dependent: :destroy
  has_many :items, through: :item_associations

  validates :day_id, presence: true, numericality: true
  validates :items, presence: true

  def self.actual(date)
    self.where(day_id: date.wday)
        .where('created_at <= ?', date)
        .order(created_at: :desc)
        .first
  end
end
