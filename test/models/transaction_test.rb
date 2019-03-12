# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  category         :integer
#  amount           :decimal(15, 8)
#  transaction_type :integer
#  status           :integer
#  pan_number       :string(255)
#  mobile_number    :string(255)
#  bank_account     :string(255)
#  ifsc             :string(255)
#  name             :string(255)
#  state            :string(255)
#  address          :string(255)
#  direction        :integer
#  owner            :boolean          default(FALSE)
#  user_id          :integer
#  wallet_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  percent          :decimal(10, 4)
#  from_id          :integer
#  data             :text(65535)
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
