class RemoveGasIdFromCartItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :gas_id, :integer
    remove_column :cart_items, :gas_amount, :integer
  end
end
