class AddPercentToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :percent, :decimal, scale: 4, precision: 10
  end
end
