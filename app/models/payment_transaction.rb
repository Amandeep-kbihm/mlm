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

class PaymentTransaction < ApplicationRecord

  belongs_to :user

  STATUS = {
      approved: 0,
      unapproved: 1,
      pending: 2
  }

  STATUS_REVERSE = {
      0 => 'Approved',
      1 => 'Unapproved',
      2 => 'Pending'
  }

  DIRECTION = {
      credit: 0,
      debit: 1
  }

  PAYMENT_TYPE = {
      paytm: 0,
      bank_transaction: 1,
      mobile_recharge: 2
  }

  PAYMENT_TYPE_REVERSE = {
      0 => 'PayTM',
      1 => 'Bank Transaction',
      2 => 'Mobile Recharge'
  }
end
