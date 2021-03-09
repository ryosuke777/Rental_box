class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.integer :gas_id
      t.integer :bring_in_id
      t.integer :customer_id
      t.integer :item_amount
      t.integer :gas_amount
      t.integer :bring_in_amount

      t.timestamps
    end
  end
end
