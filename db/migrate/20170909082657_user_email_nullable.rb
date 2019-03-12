class UserEmailNullable < ActiveRecord::Migration[5.0]
  def up
    remove_index :users, :email
    change_column :users, :email, :string, null: true
    add_index :users, :email, unique: true
  end

  def down
    remove_index :users, :email
    change_column :users, :email, :string, null: false, default: ''
    add_index :users, :email, unique: true
  end
end
