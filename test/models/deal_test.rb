# == Schema Information
#
# Table name: deals
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
#  cap          :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reward_later :boolean          default(FALSE)
#

require 'test_helper'

class DealTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
