class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.integer :image_id
      t.text :introduction
      t.integer :price
      t.integer :add_price
      t.integer :power_consumption
      t.integer :fuel_economy
      t.boolean :video
      t.string :video_url
      t.boolean :manual
      t.string :manual_url

      t.timestamps
    end
  end
end
