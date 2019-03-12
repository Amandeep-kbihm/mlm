class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :category
      t.decimal :amount, precision: 10, scale: 4
      t.integer :transaction_type
      t.integer :status
      t.string :pan_number
      t.string :mobile_number
      t.string :bank_account
      t.string :ifsc
      t.string :name
      t.string :state
      t.string :address
      t.integer :direction
      t.boolean :owner, default: false

      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :wallet, index: true, foreign_key: true

      t.timestamps
    end
  end
end
