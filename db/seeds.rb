require 'csv'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Order.delete_all
Customer.delete_all
Product.delete_all
Provinces.delete_all
Category.delete_all


ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='orders';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='customers';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='provinces';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories';")

categories = Rails.root.join('db/item_categories.csv')
products = Rails.root.join('db/items.csv')
description = Rails.root.join('db/item_prose.csv')

puts "Loading categories from the csv file: #{categories}"
puts "Loading products from the csv file: #{products}"
puts "Loading descriptions from the csv file: #{description}"

csv_cat = File.read(categories)
csv_prod = File.read(products)
csv_desc = File.read(description)

pokemon_categories = CSV.parse(csv_cat, headers: true, encoding: "utf-8")
pokemon_products = CSV.parse(csv_prod, headers: true, encoding: "utf-8")
pokemon_desc = CSV.parse(csv_desc, headers: true, encoding: "utf-8")

provinces_data = [
  { prov_name: 'Alberta', GST: 0.05, PST: 0.0, HST: 0.0 },
  { prov_name: 'British Columbia', GST: 0.05, PST: 0.07, HST: 0.0 },
  { prov_name: 'Manitoba', GST: 0.05, PST: 0.08, HST: 0.0 },
  { prov_name: 'New Brunswick', GST: 0.05, PST: 0.10, HST: 0.0 },
  { prov_name: 'Newfoundland and Labrador', GST: 0.05, PST: 0.10, HST: 0.0 },
  { prov_name: 'Nova Scotia', GST: 0.05, PST: 0.10, HST: 0.0 },
  { prov_name: 'Ontario', GST: 0.05, PST: 0.08, HST: 0.0 },
  { prov_name: 'Prince Edward Island', GST: 0.05, PST: 0.10, HST: 0.0 },
  { prov_name: 'Quebec', GST: 0.05, PST: 0.09975, HST: 0.0 },
  { prov_name: 'Saskatchewan', GST: 0.05, PST: 0.06, HST: 0.0 },
  { prov_name: 'Northwest Territories', GST: 0.05, PST: 0.0, HST: 0.0 },
  { prov_name: 'Nunavut', GST: 0.05, PST: 0.0, HST: 0.0 },
  { prov_name: 'Yukon', GST: 0.05, PST: 0.0, HST: 0.0 },
]

provinces_data.each do |province|
  Province.create(province)
end

pokemon_categories.each do |p|

    poke_cat =  Category.create(
        cat_name: p["identifier"]
    )
    
end

pokemon_products.each do |p|
  image_path = Rails.root.join("app", "assets", "images", "#{p["identifier"]}.png")
  description = pokemon_desc.find { |d| p["id"] == d["item_id"] }&.dig("short_effect")

  if File.exist?(image_path)
    poke_prod = Product.create(
      prod_name: p["identifier"],
      cost: p["cost"],
      category_id: p["category_id"],
      description: description
    )

    poke_prod.image.attach(io: File.open(image_path), filename: "#{p["identifier"]}.png", content_type: 'image/png')
  else
    # If the image file doesn't exist, use a default image
    default_image_path = Rails.root.join("app", "assets", "images", "default.png")

    poke_prod = Product.create(
      prod_name: p["identifier"],
      cost: p["cost"],
      category_id: p["category_id"],
      description: description
    )

    poke_prod.image.attach(io: File.open(default_image_path), filename: "default.png", content_type: 'image/png')
  end

  sleep(1)
end


