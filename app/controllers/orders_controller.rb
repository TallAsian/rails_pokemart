class OrdersController < ApplicationController
    before_action :authenticate_customer!  # Ensure the customer is logged in
  
    def index
      @orders = Order.where(customers_id: current_customer.id)  # Fetch the orders for the logged-in customer
    end
  end
  