class MenuItemsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_menu_item, only: %i[ show edit update destroy ]
  before_action :set_categories, only: %i[ index new create edit update ]

  def index
    @menu_items = MenuItem.with_rich_text_description
                          .by_category(params[:category])
                          .where(active: true)
  end

  def show
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      redirect_to @menu_item, notice: "Menu item created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @menu_item.update(menu_item_params)
      redirect_to @menu_item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @menu_item.destroy
    redirect_to menu_items_path, noticed: "Menu item was successfully deleted."
  end

  private

  def set_menu_item
    @menu_item = MenuItem.includes(:category).find(params[:id])
  end

  def set_categories
    @categories = Category.order(:name)
  end

  def menu_item_params
    params.expect(
      menu_item: [
        :name, :price, :inventory_count, :active, :category_id, :description
      ]
    )
  end
end
