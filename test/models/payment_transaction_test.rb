# == Schema Information
#
# Table name: payment_transactions
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  user_id          :integer
#  amount           :decimal(15, 8)
#  transaction_type :integer
#  status           :integer
#  pan_number       :string(255)
#  mobile_number    :string(255)
#  bank_account     :string(255)
#  ifsc             :string(255)
#  email            :string(255)
#  state            :string(255)
#  address          :string(255)
#  direction        :integer
#  wallet_id        :integer
#  payment_type     :string(255)
#  operator         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class PaymentTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
