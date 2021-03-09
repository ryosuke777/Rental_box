class CreateGases < ActiveRecord::Migration[5.2]
  def change
    create_table :gases do |t|
      t.string :name
      t.integer :amount
      t.integer :price
      t.boolean :is_active

      t.timestamps
    end
  end
end
