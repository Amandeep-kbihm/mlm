class AddOtpToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :otp, :string
  end
end
