class AddCategoryToMenuItems < ActiveRecord::Migration[8.1]
  def change
    add_reference :menu_items, :category, null: false, foreign_key: true
  end
end
