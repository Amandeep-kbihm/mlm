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

class Transaction < ApplicationRecord

  belongs_to :user
  belongs_to :wallet
  belongs_to :from, class_name: User

  validates :category, :wallet_id, :user_id, :direction, presence: true
  validates :owner, inclusion: { in: [ true, false ] }

  TRANSACTION_TYPE = {
      wallet: 0
  }

  TRANSACTION_TYPE_REVERSE = {
      0 => 'Wallet'
  }

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

  DIRECTION_REVERSE = {
      0 => 'Credit',
      1 => 'Debit'
  }

  CATEGORY = {
      pay_per_refer: 0,
      pay_per_install: 1,
      pay_per_view: 2,
      pay_per_click: 3,
      refund: 4,
      deduct: 5
  }

  CATEGORY_REVERSE = {
      0 => 'Pay Per Refer',
      1 => 'Pay Per Install',
      2 => 'Pay Per View',
      3 => 'Pay Per Click',
      4 => 'Refund',
      5 => 'Deduct'
  }

end
