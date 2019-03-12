class CreateEcpmRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :ecpm_records do |t|
      t.integer :transaction_count
      t.string :transaction_category
      t.float :ecpm_value
      t.float :ecpm_min
      t.float :ecpm_max
      t.float :select_ecpm_value
      t.date :transaction_date

      t.timestamps
    end
  end
end
