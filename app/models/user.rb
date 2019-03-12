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

class User < ApplicationRecord
  rolify
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :sponsor, class_name: 'User', primary_key: :refer_id
  belongs_to :real_sponsor, class_name: 'User', primary_key: :refer_id
  has_one :wallet, dependent: :destroy
  has_one :nominee, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :limits, dependent: :destroy
  has_many :refers, class_name: UserRefer, foreign_key: :refer_id, dependent: :destroy
  has_many :referreds, class_name: UserRefer, foreign_key: :referred_id, dependent: :destroy
  has_many :payment_transactions, dependent: :destroy

  validates :refer_id, :mobile_number, presence: true
  validates :mobile_number, uniqueness: true

  after_create :create_nominee, :create_wallet

  STATUS = {
      unactivated: 1,
      activated: 2,
      blocked: 3
  }.freeze

  STATUS_REVERSE = {
      1 => 'Unactivated',
      2 => 'Activated',
      3 => 'Blocked'
  }.freeze

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def create_nominee
    Nominee.create(user_id: self.id)
  end

  def create_wallet
    Wallet.create(user_id: self.id, balance: 0)
  end

  def level_1_users
    User.where(sponsor_id: self.refer_id).order(created_at: :asc)
  end

  def to_external
    {
        id: id,
        name: name,
        email: email,
        authentication_token: authentication_token,
        sponsor_id: sponsor_id,
        refer_id: refer_id,
        chain_count: chain_count,
        address: address,
        city: city,
        state: state,
        dob: dob,
        mobile_number: mobile_number,
        country: country,
        user_level: user_level,
        status: status,
        boost: boost,
        block: block
    }
  end

  def self.search(params)
    User.where(name: params[:name])
        .or(User.where(email: params[:email]))
        .or(User.where(mobile_number: params[:mobile_number]))
        .or(User.where(refer_id: params[:refer_id]))
        .or(User.where(sponsor_id: params[:sponsor_id]))
        .or(User.where(status: params[:status]))
  end

end
