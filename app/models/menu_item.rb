class MenuItem < ApplicationRecord
  belongs_to :category

  scope :by_category, ->(category) { where(category: category) if category.present? }
end
