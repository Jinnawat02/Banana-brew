class DashboardController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @menu_items = MenuItem.with_rich_text_description
                      .with_attached_image
                      .by_category(params[:category])
                      .where(active: true)
                      .where("inventory_count > ?", 0)
    @categories = Category.order(:name)
  end

  private

  def set_categories
    @categories = Category.order(:name)
  end

  def menu_item_params
    params.expect(
      menu_item: [
        :category_id
      ]
    )
  end
end
