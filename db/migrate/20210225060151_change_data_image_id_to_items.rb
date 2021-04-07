class ChangeDataImageIdToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :image_id, :text
  end
end
