# == Schema Information
#
# Table name: bank_transactions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  wallet_id    :integer
#  amount       :decimal(10, 4)
#  status       :integer
#  pan_number   :string(255)
#  direction    :integer
#  bank_account :string(255)
#  ifsc         :string(255)
#  name         :string(255)
#  state        :string(255)
#  address      :string(255)
#  payment_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class BankTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
