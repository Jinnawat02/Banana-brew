class OrdersController < ApplicationController
  def index
    @orders = Current.user.orders
                    .includes(order_items: :menu_item)
                    .order(created_at: :desc)
  end

  def show
    @order = Current.user.orders
                    .includes(order_items: :menu_item)
                    .find(params[:id])
  end
end
