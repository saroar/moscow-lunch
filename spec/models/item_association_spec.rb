# == Schema Information
#
# Table name: item_associations
#
#  id                    :integer          not null, primary key
#  price                 :decimal(, )
#  item_id               :integer
#  item_association_id   :integer
#  item_association_type :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemAssociation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
