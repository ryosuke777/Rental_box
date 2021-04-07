class ChangeDataFuelEconomyToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :fuel_economy, :float
  end
end
