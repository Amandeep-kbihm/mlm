# == Schema Information
#
# Table name: wallets
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  balance    :decimal(15, 8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
