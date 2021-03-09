class AddPowerConsumptionOptionToBringInEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :bring_in_equipments, :power_consumption_option, :boolean
  end
end
