# == Schema Information
#
# Table name: conversions
#
#  id             :integer          not null, primary key
#  transaction_id :string(255)
#  company        :string(255)
#  company_id     :string(255)
#  user_id        :integer
#  deal_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Conversion < ApplicationRecord
  belongs_to :user
  belongs_to :deal
  belongs_to :offer

  validates :transaction_id, :company_id, :company, :user_id, presence: true

  STATUS = {
    unapproved: 1,
    approved: 2
}.freeze

STATUS_REVERSE = {
    1 => 'Unapproved',
    2 => 'Approved'
}.freeze
end
