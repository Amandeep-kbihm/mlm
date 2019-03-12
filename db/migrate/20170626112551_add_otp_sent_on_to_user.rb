class AddOtpSentOnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :otp_sent_on, :datetime, default: -> { 'NOW()' }
  end
end
