class AddGroupIdToBringInEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :bring_in_equipments, :group_id, :integer
  end
end
