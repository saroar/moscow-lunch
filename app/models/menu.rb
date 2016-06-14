# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Menu < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: { in: 1..100 }
end
