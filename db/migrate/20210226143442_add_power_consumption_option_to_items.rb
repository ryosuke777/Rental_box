class AddPowerConsumptionOptionToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :power_consumption_option, :boolean
    add_column :items, :fuel_economy_option, :boolean
  end
end
