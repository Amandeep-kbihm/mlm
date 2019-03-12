class IncreaseDecimalPointForAllTableAmounts < ActiveRecord::Migration[5.0]
  def up
    change_column :transactions, :amount, :decimal, scale: 8, precision: 15
    change_column :payment_transactions, :amount, :decimal, scale: 8, precision: 15
    change_column :wallets, :balance, :decimal, scale: 8, precision: 15
  end

  def down
    change_column :transactions, :amount, :decimal, scale: 4, precision: 10
    change_column :payment_transactions, :amount, :decimal, scale: 4, precision: 10
    change_column :wallets, :balance, :decimal, scale: 4, precision: 10
  end
end