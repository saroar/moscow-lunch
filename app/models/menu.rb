class Menu < ActiveRecord::Base
  has_many :items, dependent: :destroy

  #validates :name, presence: true, length: { in: 1..100 }
end
