class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :group_id
      t.string :item_for_sale
      t.integer :date
      t.integer :total_payment

      t.timestamps
    end
  end
end
