# == Schema Information
#
# Table name: enquiries
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  enquiry    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  status     :integer          default(0)
#

require 'test_helper'

class EnquiryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
