class CreateUserActions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_actions do |t|
      t.integer :category
      t.belongs_to :user, foreign_key: true
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
