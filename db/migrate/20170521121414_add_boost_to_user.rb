class AddBoostToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :boost, :boolean, default: false
  end
end
