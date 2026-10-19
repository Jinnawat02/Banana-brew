class Order < ApplicationRecord
  class OutOfStock < StandardError; end

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items

  def self.place!(user:, cart:)
    transaction do
      order = user.orders.create!(status: "placed", total: 0)

      cart.lines.each do |line|
        item = line.menu_item.lock!
        if item.inventory_count < line.quantity
          raise OutOfStock, "#{item.name} has only #{item.inventory_count} left."
        end

        item.decrement!(:inventory_count, line.quantity)
        order.order_items.create!(menu_item: item, quantity: line.quantity, unit_price: item.price)
      end

      order.update!(total: order.order_items.sum("unit_price * quantity"))
      order
    end
  end
end
