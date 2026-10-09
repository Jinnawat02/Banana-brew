class MenuItem < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :inventory_count, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  belongs_to :category

  scope :by_category, ->(category) { where(category: category) if category.present? }
end
