# == Schema Information
#
# Table name: ecpm_records
#
#  id                   :integer          not null, primary key
#  transaction_count    :integer
#  transaction_category :string(255)
#  ecpm_value           :float(24)
#  ecpm_min             :float(24)
#  ecpm_max             :float(24)
#  select_ecpm_value    :float(24)
#  transaction_date     :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'test_helper'

class EcpmRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
