# == Schema Information
#
# Table name: manual_apps
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  link           :string(255)
#  user_attribute :string(255)
#  caps           :integer
#  active         :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ManualApp < ApplicationRecord
  validates :name, :link, :user_attribute, :caps, presence: true
end
