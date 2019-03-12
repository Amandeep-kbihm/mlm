class AddDataToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :data, :text
  end
end
