class CreateBringInEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :bring_in_equipments do |t|
      t.string :name
      t.integer :power_consumption

      t.timestamps
    end
  end
end
