class ProductsController < ApplicationController
  def index
    @pokemon_products = Product.includes(image_attachment: :blob).all.page(params[:page]).per(30)
  end

  def show
    
  end
end
