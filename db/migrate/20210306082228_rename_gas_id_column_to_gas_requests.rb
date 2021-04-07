class RenameGasIdColumnToGasRequests < ActiveRecord::Migration[5.2]
  def change
    rename_column :gas_requests, :gas_id, :gase_id
  end
end
