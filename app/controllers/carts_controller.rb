class CartsController < ApplicationController
  allow_unauthenticated_access

  def show
    @lines = current_cart.lines

    p @lines

    @lines
  end
end
