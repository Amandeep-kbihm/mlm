class AddCityToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :dob, :date
    add_column :users, :mobile_number, :string
    add_column :users, :country, :string
  end
end
