# == Schema Information
#
# Table name: user_actions
#
#  id         :integer          not null, primary key
#  category   :integer
#  user_id    :integer
#  paid       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserAction < ApplicationRecord
  validates :category, :user_id, presence: true
  belongs_to :user
end
