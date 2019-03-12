class AddFromIdToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :from_id, :integer
    add_index :transactions, :from_id
  end
end
