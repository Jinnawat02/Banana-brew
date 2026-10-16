class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :orders

  after_create :assign_default_role

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end
end
