class CreateRequestBringInEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :request_bring_in_equipments do |t|
      t.integer :request_id
      t.integer :name
      t.integer :power_consumption
      t.integer :amount

      t.timestamps
    end
  end
end
