class CheckoutController < ApplicationController
    def index
        # Calculate total cost, taxes, and other details
        # Retrieve cart items from the session or database
        @cart_items = session[:cart].present? ? Product.where(id: session[:cart]) : [] # Retrieve cart items logic
    
        # Province filter logic
        # Find the province based on the entered name
        @province = Province.find_by(prov_name: params[:province_name])

    end
end