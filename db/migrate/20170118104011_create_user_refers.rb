class CreateUserRefers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_refers do |t|
      t.integer :level, default: 0
      t.integer :refer_id
      t.integer :referred_id

      t.timestamps
    end
  end
end
