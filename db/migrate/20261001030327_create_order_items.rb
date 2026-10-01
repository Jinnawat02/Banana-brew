class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :menu_item, null: false, foreign_key: true
      t.integer :quantity
      t.float :unit_price
      t.string :options

      t.timestamps
    end
  end
end
