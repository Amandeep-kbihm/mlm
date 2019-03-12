class AddSponsorToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sponsor_id, :string
    add_column :users, :refer_id, :string
    add_column :users, :chain_count, :integer, default: 0
    add_index :users, :refer_id, unique: true
    add_index :users, :sponsor_id
  end

end
