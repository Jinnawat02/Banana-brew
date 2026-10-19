class CartItemsController < ApplicationController
  allow_unauthenticated_access

  def create
    menu_item = MenuItem.where(active: true).find(params[:menu_item])
    current_cart.add(menu_item.id.to_s)
    redirect_back fallback_location: cart_path, notice: "#{menu_item.name} added to cart."
  end

  def update
    current_cart.update(params[:id], params[:quantity])
    redirect_to cart_path
  end

  def destroy
    current_cart.remove(params[:id])
    redirect_to cart_path, status: :see_other
  end
end
