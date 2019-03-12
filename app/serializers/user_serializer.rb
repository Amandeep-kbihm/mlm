# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(30)
#  sponsor_id             :string(255)
#  refer_id               :string(255)
#  chain_count            :integer          default(0)
#  address                :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  dob                    :date
#  mobile_number          :string(255)
#  country                :string(255)
#  real_sponsor_id        :string(255)
#  user_level             :integer          default(0)
#  status                 :integer          default(0)
#  boost                  :boolean          default(FALSE)
#  otp                    :string(255)
#  block                  :boolean          default(FALSE)
#  otp_sent_on            :datetime
#  refer_income           :integer          default(0)
#  fcm_token              :string(255)
#  forgot_password_otp    :string(255)
#  device_id              :string(255)
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :authentication_token, :mobile_number, :refer_id, :sponsor_id, :status, :chain_count, :name, :country, :state, :city, :address, :dob, :boost, :created_at
end
