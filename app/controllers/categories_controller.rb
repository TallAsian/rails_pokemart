class CategoriesController < ApplicationController
  def index
    @pokemon_categories = Category.all.page(params[:page]).per(30)
  end

  def show
  end
end
