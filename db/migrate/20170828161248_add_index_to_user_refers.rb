class AddIndexToUserRefers < ActiveRecord::Migration[5.0]
  def change
    add_index :user_refers, :refer_id
    add_index :user_refers, :referred_id
  end
end
