class CategoriesController < ApplicationController
  def index
    @pokemon_categories = Category.all.page(params[:page]).per(30)
  end

  def show
    @pokemon_category = Category.find(params[:id])
    @pokemon_products = @pokemon_category.products.page(params[:page]).per(9)
  end  
end
