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
  def recently_added
    @pokemon_products = Product.includes(image_attachment: :blob)
                              .where("created_at >= ?", 3.days.ago)
                              .order(created_at: :desc)
                              .page(params[:page])
                              .per(30)
    render :index
  end

  def recently_updated
    @pokemon_products = Product.includes(image_attachment: :blob)
                              .where("updated_at >= ?", 3.days.ago)
                              .order(updated_at: :desc)
                              .page(params[:page])
                              .per(30)
    render :index
  end
  def add_to_cart
    @pokemon_products = Product.find(params[:id])
    @pokemon_products.add_to_cart(session)
    redirect_to products_path, notice: 'Product added to cart!'
  end
  def cart
    @cart_items = session[:cart].present? ? Product.where(id: session[:cart]) : []
  end
  def remove_from_cart
    @pokemon_product = Product.find(params[:id])
    session[:cart].delete(@pokemon_product.id)
    redirect_to cart_path, notice: 'Product removed from cart!'
  end
end
