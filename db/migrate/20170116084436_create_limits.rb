class CreateLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :limits do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :ppc, default: 0
      t.integer :ppv, default: 0
      t.integer :ppi, default: 0

      t.timestamps
    end
  end
end
