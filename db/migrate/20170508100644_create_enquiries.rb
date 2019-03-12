class CreateEnquiries < ActiveRecord::Migration[5.0]
  def change
    create_table :enquiries do |t|
      t.string :subject
      t.text :enquiry

      t.timestamps
    end
  end
end
