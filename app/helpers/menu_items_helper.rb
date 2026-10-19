module MenuItemsHelper
  def category_selected?(category, selected)
    category.id.to_s == selected.to_s
  end

  def menu_item_image(item)
    if item.image.attached? && item.image.persisted?
      image_tag item.image, alt: item.name, class: "h-full w-full object-cover"
    else
      tag.svg(class: "size-16") { tag.use(href: "#cup") }
    end
  end
end
