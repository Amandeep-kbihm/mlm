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

class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :user_id, uniqueness: true

  def add_money(amount)
    self.balance += amount
    self.save
  end

  def deduct_money(amount)
    self.balance -= amount
    self.save
  end

end
