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

require 'test_helper'

class UserReferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
