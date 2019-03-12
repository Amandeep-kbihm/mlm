class AddDeviceIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :device_id, :string, unique: true
  end
end
