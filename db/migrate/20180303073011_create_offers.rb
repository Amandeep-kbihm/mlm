class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :company_id
      t.integer :downloaded, default: 0
      t.string :link
      t.string :logo
      t.string :name
      t.text :instructions
      t.boolean :active, default: false
      t.decimal :amount, scale: 4, precision: 10
      t.integer :cap, default: 0
      t.boolean :reward_later, default: false

      t.timestamps
    end
  end
end
