class MenuItemsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_menu_item, only: %i[show edit]

  def index
    @memu_items = MenuItem.by_category(params[:category]).where(active: true)
    @categories = Category.order(:name)
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_menu_item
    @memu_item = MenuItem.includes(:category).find(params[:id])
  end
end
