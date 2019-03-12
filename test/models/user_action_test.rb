# == Schema Information
#
# Table name: user_actions
#
#  id         :integer          not null, primary key
#  category   :integer
#  user_id    :integer
#  paid       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserActionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
