# == Schema Information
#
# Table name: limits
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ppc        :integer          default(0)
#  ppv        :integer          default(0)
#  ppv2       :integer          default(0)
#  ppi        :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Limit < ApplicationRecord
  belongs_to :user
end
