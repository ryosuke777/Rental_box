class RenameCustomerIdColumnToCartItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :cart_items, :customer_id, :group_id
  end
end
