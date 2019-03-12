class CreateManualApps < ActiveRecord::Migration[5.0]
  def change
    create_table :manual_apps do |t|
      t.string :name
      t.string :link
      t.string :user_attribute
      t.integer :caps
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
