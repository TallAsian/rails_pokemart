class CheckoutController < ApplicationController
    def index
        # Calculate total cost, taxes, and other details
        # Retrieve cart items from the session or database
        @cart_items = session[:cart].present? ? Product.where(id: session[:cart]) : [] # Retrieve cart items logic
    
        # Province filter logic
        # Find the province based on the entered name
        if params[:province_name].present?
            @province = Provinces.find_by(prov_name: params[:province_name])
        end
        if @province.present?
            # Find the province based on the entered name
              # Create a new customer with a random hash and associate with the province
              customer = Customer.create(
              cust_name: SecureRandom.hex(8),
              provinces_id: @province.id # Use @province.id directly
              )
          
              # Loop through cart items to create orders for each item
              @cart_items.each do |item|
              order = Order.create(
                  customers_id: customer.id.to_i,
                  products_id: item.id.to_i,
                  quantity: session[:quantity][item.id.to_s].to_i
              )
              end
        
            redirect_to success_path_url # Redirect to a success page or another relevant action
        end
        

        # Calculate total cost with taxes
    end
      
end