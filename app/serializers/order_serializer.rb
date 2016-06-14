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

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :created_at

  has_one :user
  has_one :organization

  has_many :items
end
