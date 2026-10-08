# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

password = ENV['SEED_PASSWORD'] || 'password'
find_admin = User.find_by(email_address: 'admin@example.com').presence
find_customer = User.find_by(email_address: 'customer@example.com').presence
unless find_admin && find_customer
  User.create(email_address: 'admin@example.com', password: password)
  User.create(email_address: 'customer@example.com', password: password)
  p 'Seeded user model'
end

categories = %w[ Dessert Milk Coffee Tea ]
if Category.count.zero?
  categories.each { |category| Category.create(name: category) }
  p 'Seeded category model'
end

menu_items = [
  { name: 'Cake', price: 60, inventory_count: 10, active: true, category: Category.find_by(name: 'Dessert') },
  { name: 'Brownie', price: 25, inventory_count: 25, active: true, category: Category.find_by(name: 'Dessert') },
  { name: 'Pie', price: 30, inventory_count: 15, active: true, category: Category.find_by(name: 'Dessert') },
  { name: 'Donut', price: 10, inventory_count: 40, active: true, category: Category.find_by(name: 'Dessert') },
  { name: 'Brown Sugar', price: 40, inventory_count: 25, active: true, category: Category.find_by(name: 'Milk') },
  { name: 'Matcha Milk', price: 45, inventory_count: 25, active: true, category: Category.find_by(name: 'Milk') },
  { name: 'Hokkaido Milk', price: 40, inventory_count: 25, active: true, category: Category.find_by(name: 'Milk') },
  { name: 'Americano', price: 50, inventory_count: 25, active: true, category: Category.find_by(name: 'Coffee') },
  { name: 'Espresso', price: 40, inventory_count: 25, active: true, category: Category.find_by(name: 'Coffee') },
  { name: 'Cappuccino', price: 40, inventory_count: 25, active: true, category: Category.find_by(name: 'Coffee') },
  { name: 'Latte', price: 40, inventory_count: 25, active: true, category: Category.find_by(name: 'Coffee') },
  { name: 'Matcha', price: 50, inventory_count: 25, active: true, category: Category.find_by(name: 'Tea') },
  { name: 'Thai Tea', price: 30, inventory_count: 25, active: true, category: Category.find_by(name: 'Tea') }
]
if MenuItem.count.zero?
  menu_items.each { |item| MenuItem.create(name: item[:name], price: item[:price], inventory_count: item[:inventory_count], active: item[:active], category: item[:category]) }
  p 'Seeded menu item model'
end
