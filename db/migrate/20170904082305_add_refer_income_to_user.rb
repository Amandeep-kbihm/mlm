class AddReferIncomeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :refer_income, :integer, default: 0
  end
end
