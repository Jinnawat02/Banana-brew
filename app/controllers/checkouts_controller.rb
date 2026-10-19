class CheckoutsController < ApplicationController
  def create
    return redirect_to(cart_path, alert: "Your cart is empty.") if current_cart.lines.empty?

    order = Order.place!(user: Current.user, cart: current_cart)
    current_cart.clear
    redirect_to order_path(order), notice: "Order placed!"
  rescue Order::OutOfStock, ActiveRecord::RecordInvalid => e
    redirect_to cart_path, alert: e.message
  end
end
