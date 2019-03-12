class CreateWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :wallets do |t|
      t.belongs_to :user
      t.decimal :balance, precision: 10, scale: 4

      t.timestamps
    end
  end
end
