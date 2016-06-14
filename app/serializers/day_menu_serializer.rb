# == Schema Information
#
# Table name: day_menus
#
#  id         :integer          not null, primary key
#  day_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DayMenuSerializer < ActiveModel::Serializer
  attributes :id
end
