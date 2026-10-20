class CartsController < ApplicationController
  allow_unauthenticated_access

  def show
    @lines = current_cart.lines
  end
end
