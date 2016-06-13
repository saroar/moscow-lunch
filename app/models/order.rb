class Order < ActiveRecord::Base
  include Filterable

  before_create :total_price
  before_create :set_organization

  belongs_to :user
  belongs_to :organization
  has_many :item_associations, as: :item_association, dependent: :destroy
  has_many :items, through: :item_associations

  validates :user,  presence: true
  validates :items, presence: true

  scope :date, -> (date) { where created_at: date.beginning_of_day..date.end_of_day }
  scope :organization, -> (organization) { joins(:organization).where("organizations.name like ?", "#{organization}%") }

  private

  def total_price
    self.total = items.map(&:price).sum
  end

  def set_organization
    self.organization = user.organization
  end
end
