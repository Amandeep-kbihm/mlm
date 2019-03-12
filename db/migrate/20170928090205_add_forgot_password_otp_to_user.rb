class AddForgotPasswordOtpToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :forgot_password_otp, :string
  end
end
