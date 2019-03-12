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

require 'test_helper'

class ConversionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
