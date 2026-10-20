class CreateMenuItems < ActiveRecord::Migration[8.1]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :inventory_count
      t.boolean :active

      t.timestamps
    end
  end
end
