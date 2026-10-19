class MenuItem < ApplicationRecord
  IMAGE_TYPES    = %w[image/jpeg image/png image/webp].freeze
  MAX_IMAGE_SIZE = 5.megabytes

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 400, 300 ]
    attachable.variant :display, resize_to_limit: [ 1200, 900 ]
  end

  has_rich_text :description

  validates :name, presence: true
  validates :price, presence: true
  validates :inventory_count, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  validate :acceptable_image

  belongs_to :category
  has_many :order_items

  scope :by_category, ->(category) { where(category: category) if category.present? }

  private

  def acceptable_image
    return unless image.attached?

    unless image.content_type.in?(IMAGE_TYPES)
      errors.add(:image, "must be a JPEG, PNG, or WebP image")
    end

    if image.byte_size > MAX_IMAGE_SIZE
      errors.add(:image, "must be smaller than 5 MB")
    end
  end
end
