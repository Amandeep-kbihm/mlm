class CreateNominees < ActiveRecord::Migration[5.0]
  def change
    create_table :nominees do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.integer :age
      t.string :gender
      t.string :relation
      t.string :address
      t.string :contact

      t.timestamps
    end
  end
end
