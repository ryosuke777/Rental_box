class CreateGasRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :gas_requests do |t|
      t.integer :gas_id
      t.integer :group_id
      t.integer :gas_amount

      t.timestamps
    end
  end
end
