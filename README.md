# Banana Brew ☕

A coffee shop web app I built to practice **Ruby on Rails 8**. Customers browse the menu,
add drinks and desserts to a cart, and place orders. Admins manage menu items and categories.

> This is a learning project, not a production app. See [Known issues](#known-issues--next-steps).

---

## What I practiced

| Topic | What I built | Where to look |
|---|---|---|
| **Models & associations** | `Category` → `MenuItem` → `OrderItem` ← `Order` ← `User`, including `has_many :through` | `app/models/` |
| **CRUD & RESTful routes** | Full create/read/update/delete for menu items and categories | `MenuItemsController`, `CategoriesController`, `config/routes.rb` |
| **Forms** | `form_with`, `collection_select`, radio buttons, strong parameters (`params.expect`), validation error messages | `app/views/menu_items/_form.html.erb`, `shared/_form_errors` |
| **Scopes & filtering** | Filter the menu by category with a scope and query params | `MenuItem.by_category`, `shared/_category_tab` |
| **Authentication** | Rails 8 built-in authentication generator (sessions, password reset) | `app/controllers/concerns/authentication.rb` |
| **Authorization** | Admin and customer roles with the `rolify` gem; admin-only links and actions | `User`, `dashboard/index`, `menu_items/show` |
| **Rich text** | Menu item descriptions with Action Text (Trix editor) | `has_rich_text :description` |
| **Session cart** | Cart stored in the session (no database rows) until checkout | `app/models/cart.rb`, `CurrentCart` concern |
| **Transactions** | Checkout creates the order, saves line items with the price at the time, and reduces stock, all or nothing | `Order.place!`, `CheckoutsController` |
| **Scoped data access** | Customers can only see their own orders (`Current.user.orders.find`) | `OrdersController` |
| **N+1 queries** | Preloading with `includes`, `with_rich_text_description`, `with_attached_image` | `DashboardController`, `OrdersController` |
| **File uploads** | Menu item photos with Active Storage, with content-type and size validation | `has_one_attached :image`, `MenuItemsHelper#menu_item_image` |
| **Styling** | Tailwind CSS v4 with a small design system (buttons, inputs, cards, tables, badges) and dark mode | `app/assets/tailwind/application.css` |
| **Hotwire (Turbo)** | `button_to` for non-GET actions, `turbo_confirm` dialogs, `303 See Other` redirects after DELETE | `carts/show`, `menu_items/index` |
| **Seeds & config** | Idempotent-ish seed data, environment variables with `dotenv` | `db/seeds.rb`, `.env` |

### Lessons that stuck
- `link_to` always sends **GET**. Use `button_to` for POST/PATCH/DELETE. `data: { method: ... }` is Rails 6 (rails-ujs) and does nothing in Rails 7+.
- Instance variables don't survive between requests. Every action that needs `@record` must load it (`before_action :set_record`).
- An unset instance variable is `nil`, not an error, so a typo like `@memu_item` fails later, somewhere else.
- `params` values are always strings. Session keys become strings too, because the session is serialized to JSON.
- `create` returns `false` silently. Inside a transaction use `create!` so a failure rolls everything back.
- `rescue SomeClass` crashes with `NameError` if `SomeClass` isn't defined, and hides the original error.
- Tailwind only generates classes it can find written out in full in your files.
- Calling `.to_s` on an object gives `#<Class:0x...>`, a different string for each instance. Store IDs, not objects.

---

## Features

**Customers (guests can browse and use the cart)**
- Browse the menu, filtered by category
- Menu item page with photo, price, stock and rich-text description
- Session cart: add, change quantity, remove
- Log in to place an order; view order history

**Admins**
- Manage menu items (with photo upload) and categories
- Admin-only links on the dashboard and menu item pages

---

## Tech stack

- Ruby 4.0 · Rails 8.1 · SQLite
- Hotwire (Turbo + Stimulus) · Importmap · Propshaft
- Tailwind CSS v4 (`tailwindcss-rails`)
- Action Text · Active Storage
- `rolify` (roles) · `dotenv` (environment variables)

---

## Getting started

**Requirements:** Ruby (see `.ruby-version`), Bundler, SQLite.

```bash
bundle install

# Seed users read their password from SEED_PASSWORD
echo "SEED_PASSWORD=choose-a-password" > .env

bin/rails db:setup      # create database, load schema, run seeds
bin/dev                 # Rails server + Tailwind watcher
```

Open http://localhost:3000.

Seeded accounts (password = `SEED_PASSWORD`):

| Email | Role |
|---|---|
| `admin@example.com` | admin |
| `customer@example.com` | customer |

`.env` is gitignored. Never commit real passwords or keys.

---

## Known issues / next steps

- **`rolify` is in the `development, test` group** of the `Gemfile`. `User` calls `rolify`, so the app would not boot in production. Move the gem out of the group.
- **Images show the original file.** Resizing with named variants (`:thumb`, `:display`) needs libvips, which isn't installed on my machine (Intel Ruby and Homebrew under Rosetta on an M1 Mac). The variants are defined in `MenuItem` but not used yet.
- **The cup placeholder icon doesn't render.** Views reference `<use href="#cup">`, but no `<symbol id="cup">` is defined.
- **Tests don't run.** Fixtures are still generator placeholders (for example `belongs_to: MyString` in `menu_items.yml`).
- **Money is stored as `float`.** `price`, `unit_price` and `total` should be `decimal(10, 2)`.
- **Seeds** fall back to a default password when `SEED_PASSWORD` is missing, and can fail if only one of the two seed users exists.
- **Admin pages check the role only in views.** Any logged-in customer can open `/menu_items` or `/categories` directly and edit data. The controllers need a server-side check (`before_action :require_admin`).

### Ideas to try next
- Add to cart from the dashboard cards; live cart updates with Turbo Streams
- Admin view of all orders with status changes (`placed → preparing → done`)
- Drink options (sweetness, hot/iced) on order items
- Image variants once libvips is available; direct uploads; cloud storage
