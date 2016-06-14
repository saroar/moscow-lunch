# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_organizations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_7b93e0061c  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Organization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
