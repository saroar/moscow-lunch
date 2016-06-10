class Organization < ActiveRecord::Base
  has_many :users, dependent: :destroy

  #validates :name, presence: true, length: { in: 1..100 }
end
