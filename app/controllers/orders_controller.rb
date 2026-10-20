class OrdersController < ApplicationController
  include MenuItemsHelper

  def index
    @orders = Current.user.orders
                    .includes(order_items: { menu_item: { image_attachment: :blob } })
                    .order(created_at: :desc)
  end

  def show
    @order = Current.user.orders
                    .includes(order_items: { menu_item: { image_attachment: :blob } })
                    .find(params[:id])
  end
end
