class ChangeDataNameToRequestBringInEquipments < ActiveRecord::Migration[5.2]
  def change
  	change_column :request_bring_in_equipments, :name, :string
  end
end
