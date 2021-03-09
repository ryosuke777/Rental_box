class AddAmountToBringInEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :bring_in_equipments, :amount, :integer
  end
end
