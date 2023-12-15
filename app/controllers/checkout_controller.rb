class CheckoutController < ApplicationController
    def index
      # Calculate total cost, taxes, and other details
      # Retrieve cart items from the session or database
      @cart_items = session[:cart].present? ? Product.where(id: session[:cart]) : [] # Retrieve cart items logic
  
      if customer_signed_in?
        @province = Provinces.find_by(id: current_customer.provinces_id)
      elsif params[:province_name].present?
        @province = Provinces.find_by(prov_name: params[:province_name])
      end
  
      if @province.present?
        # Find the province based on the entered name
        # Create a new customer with a random hash and associate with the province
        if customer_signed_in?
          @cart_items.each do |item|
            order = Order.create(
              customers_id: current_customer.id.to_i,
              products_id: item.id.to_i,
              quantity: session[:quantity][item.id.to_s].to_i
            )
          end
        else
            email = "#{SecureRandom.hex(5)}@gmail.com"
            password =  SecureRandom.hex(8)
            customer = Customer.new(
                cust_name: SecureRandom.hex(8),
                provinces_id: @province.id,
                email: email,  # Set a valid email address
                password: password,       # Set a secure password
                password_confirmation: password  # Confirm the password
            )
                
            if customer.save
            # User (customer) has been saved successfully
            else
            # Handle validation errors
                errors = customer.errors.full_messages.join(', ')
                flash[:alert] = "Failed to create customer: #{errors}"
            end
              
          
          # Loop through cart items to create orders for each item
            @cart_items.each do |item|
                order = Order.create(
                customers_id: customer.id.to_i,
                products_id: item.id.to_i,
                quantity: session[:quantity][item.id.to_s].to_i
                )
            end
        end
      end
    end
  end
  