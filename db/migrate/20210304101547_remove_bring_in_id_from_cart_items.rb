class RemoveBringInIdFromCartItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :bring_in_id, :integer
    remove_column :cart_items, :bring_in_amount, :integer
  end
end
