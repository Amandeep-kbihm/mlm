class CreatePaymentTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_transactions do |t|
      t.string :name
      t.belongs_to :user
      t.decimal :amount, precision: 10, scale: 4
      t.integer :transaction_type
      t.integer :status
      t.string :pan_number
      t.string :mobile_number
      t.string :bank_account
      t.string :ifsc
      t.string :email
      t.string :name
      t.string :state
      t.string :address
      t.integer :direction
      t.integer :wallet_id
      t.string :payment_type
      t.string :operator

      t.timestamps
    end
  end
end
