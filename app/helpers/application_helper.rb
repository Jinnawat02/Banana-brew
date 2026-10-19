module ApplicationHelper
  def baht(amount)
    number_to_currency(amount, unit: "฿")
  end
end
