class Cart
  Line = Struct.new(:menu_item, :quantity) do
    def sub_total = menu_item.price * quantity
  end

  def initialize(session)
    @session = session
  end

  def add(menu_item, quantity = 1)
    key = menu_item.to_s

    items[key] = items.fetch(key, 0) + quantity.to_i
  end

  def update(menu_item_id, quantity)
    quantity = quantity.to_i
    quantity.positive? ? items[menu_item_id.to_s] = quantity : remove(menu_item_id)
  end

  def remove(menu_item_id)
    items.delete(menu_item_id.to_s)
  end

  def clear
    @session.delete(:cart)
  end

  def empty?
    items.empty?
  end

  def count
    items.values.sum
  end

  def size = items.size

  def lines
    menu_items = MenuItem.where(id: items.keys, active: true).index_by(&:id)
    items.filter_map do |id, quantity|
      item = menu_items[id.to_i]
      Line.new(item, quantity) if item
    end
  end

  private

  def items
    @session[:cart] = {} unless @session[:cart].is_a?(Hash)
    @session[:cart]
  end
end
