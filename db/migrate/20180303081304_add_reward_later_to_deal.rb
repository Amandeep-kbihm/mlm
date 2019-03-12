class AddRewardLaterToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :reward_later, :boolean, default: false
  end
end
