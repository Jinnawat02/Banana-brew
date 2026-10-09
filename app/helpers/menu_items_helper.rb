module MenuItemsHelper
  def category_selected?(category, selected)
    category.id.to_s == selected.to_s
  end
end
