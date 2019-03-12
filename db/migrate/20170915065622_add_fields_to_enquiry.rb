class AddFieldsToEnquiry < ActiveRecord::Migration[5.0]
  def change
    add_reference :enquiries, :user, foreign_key: true
    add_column :enquiries, :status, :integer, default: 0
  end
end
