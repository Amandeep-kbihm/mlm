class AddOfferReferenceToConversion < ActiveRecord::Migration[5.0]
  def change
    add_reference :conversions, :offer, foreign_key: true
  end
end
