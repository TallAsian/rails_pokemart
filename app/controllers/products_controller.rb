class ProductsController < ApplicationController
  def index
    @pokemon_products = Product.includes(image_attachment: :blob).all.page(params[:page]).per(30)
  end

  def show
    @pokemon_products = Product.find(params[:id])
    @pokemon_categories = Category.find_by(id: @pokemon_products.category_id)
  end
end
