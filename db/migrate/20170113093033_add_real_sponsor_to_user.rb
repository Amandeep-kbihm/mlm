class AddRealSponsorToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :real_sponsor_id, :string
    add_index :users, :real_sponsor_id
  end
end
