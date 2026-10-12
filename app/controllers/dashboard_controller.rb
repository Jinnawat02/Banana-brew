class DashboardController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @menu_items = MenuItem.with_rich_text_description
                      .by_category(params[:category])
                      .where(active: true)
    @categories = Category.order(:name)
  end
end
