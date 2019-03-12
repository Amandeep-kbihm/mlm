# == Schema Information
#
# Table name: nominees
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  age        :integer
#  gender     :string(255)
#  relation   :string(255)
#  address    :string(255)
#  contact    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Nominee < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true
end
