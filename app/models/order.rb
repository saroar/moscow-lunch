# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  total           :decimal(, )
#  user_id         :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_orders_on_organization_id  (organization_id)
#  index_orders_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_f868b47f6a  (user_id => users.id)
#  fk_rails_fe8af6535c  (organization_id => organizations.id)
#

class Order < ActiveRecord::Base
  include Filterable

  before_create :total_price
  before_create :set_organization

  belongs_to :user
  belongs_to :organization
  has_many :item_associations, as: :item_association, dependent: :destroy
  has_many :items, through: :item_associations

  validates :user,  presence: true
  validates :items, presence: true, order_items: true

  scope :date, -> (date) { where created_at: date.beginning_of_day..date.end_of_day }
  scope :organization, -> (organization) { joins(:organization).where('organizations.name like ?', "#{organization}%") }

  private

  def total_price
    self.total = items.map(&:price).sum
  end

  def set_organization
    self.organization = user.organization
  end
end
