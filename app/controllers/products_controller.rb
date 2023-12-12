class ProductsController < ApplicationController
  def index
    @pokemon_products = Product.includes(image_attachment: :blob).all.page(params[:page]).per(30)
  end

  def show
    @pokemon_products = Product.find(params[:id])
    @pokemon_categories = Category.find_by(id: @pokemon_products.category_id)
  end
  def search
    keywords = params[:keywords].gsub(" ", "%")
    wildcard_search = "%#{keywords}%"
    cat_id = params[:search][:cat_id]

    if cat_id.present?
      @pokemon_products = Product.where("prod_name LIKE ? AND category_id = ?", wildcard_search, cat_id).page(params[:page]).per(30)
    else  
      @pokemon_products = Product.where("prod_name LIKE ?", wildcard_search).page(params[:page]).per(30)
    end
  end
end
