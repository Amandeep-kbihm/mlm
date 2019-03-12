# == Schema Information
#
# Table name: user_refers
#
#  id          :integer          not null, primary key
#  level       :integer          default(0)
#  refer_id    :integer
#  referred_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserRefer < ApplicationRecord
  belongs_to :refer, class_name: User
  belongs_to :referred, class_name: User
end
