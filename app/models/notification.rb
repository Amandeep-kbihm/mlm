# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
end
