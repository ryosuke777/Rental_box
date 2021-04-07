class RenameOrderIdColumnToOrderItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_items, :order_id, :request_id
  end
end
