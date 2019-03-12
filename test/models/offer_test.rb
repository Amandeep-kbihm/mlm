# == Schema Information
#
# Table name: offers
#
#  id           :integer          not null, primary key
#  company_id   :integer
#  downloaded   :integer          default(0)
#  link         :string(255)
#  logo         :string(255)
#  name         :string(255)
#  instructions :text(65535)
#  active       :boolean          default(FALSE)
#  amount       :decimal(10, 4)
#  cap          :integer          default(0)
#  reward_later :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
