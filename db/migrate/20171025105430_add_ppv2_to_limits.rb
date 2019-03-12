class AddPpv2ToLimits < ActiveRecord::Migration[5.0]
  def change
    add_column :limits, :ppv2, :integer, after: :ppv, default: 0
  end
end
