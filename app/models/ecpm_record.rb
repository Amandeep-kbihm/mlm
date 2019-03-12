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

class EcpmRecord < ApplicationRecord

  validates :ecpm_value, :ecpm_min, :ecpm_max, :transaction_count, :transaction_category,
            :transaction_date, presence: true

end
