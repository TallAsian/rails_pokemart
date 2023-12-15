class CartController < ApplicationController
  def index
    @cart_items = if session[:cart].present?
      Product.where(id: session[:cart]).page(params[:page]).per(30)
    else
      []
    end
  end
end
