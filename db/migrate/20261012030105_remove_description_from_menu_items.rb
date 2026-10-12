class RemoveDescriptionFromMenuItems < ActiveRecord::Migration[8.1]
  def change
    remove_column :menu_items, :description, :text
  end
end
