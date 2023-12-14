class CheckoutController < ApplicationController
    def show
      # Calculate total cost, taxes, and other details
      # Retrieve cart items from the session or database
      @cart_items = # Retrieve cart items logic
  
      # Render the checkout page with invoice details
    end
  
    def create
      # Process the checkout and save order details
      # Redirect to a thank you page or order confirmation
    end
  end