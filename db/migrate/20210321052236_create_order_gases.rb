class CreateOrderGases < ActiveRecord::Migration[5.2]
  def change
    create_table :order_gases do |t|
      t.integer :gase_id
      t.integer :request_id
      t.integer :price
      t.integer :amount

      t.timestamps
    end
  end
end
