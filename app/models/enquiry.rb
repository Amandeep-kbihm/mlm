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

class Enquiry < ApplicationRecord
  belongs_to :user

  validates :subject, :enquiry, :user_id, presence: true

  STATUS = {
      unresolved: 0,
      resolved: 1
  }

  STATUS_REVERSE = {
      0 => 'Unresolved',
      1 => 'Resolved'
  }
end
