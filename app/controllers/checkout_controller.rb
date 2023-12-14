class CheckoutController < ApplicationController
    def index
        # Calculate total cost, taxes, and other details
        # Retrieve cart items from the session or database
        @cart_items = session[:cart].present? ? Product.where(id: session[:cart]) : [] # Retrieve cart items logic
    
        # Province filter logic
        if params[:province_name].present?
          # Find the province based on the entered name
          province = Province.find_by(prov_name: params[:province_name])
    
          if province
            # Apply tax rates to cart items
            @cart_items.each do |item|
              # Calculate taxes based on the retrieved province tax rates
              hst = province.HST
              pst = province.PST
              gst = province.GST
    
              # Assuming item.cost represents the base cost
              base_cost = item.cost * session[:quantity][item.id.to_s].to_i
              hst_amount = base_cost * hst / 100
              pst_amount = base_cost * pst / 100
              gst_amount = base_cost * gst / 100
    
              # Update the item details with taxes
              item.tax_details = {
                hst: hst_amount,
                pst: pst_amount,
                gst: gst_amount
              }
    
              # Update the total cost with taxes
              item.total_cost_with_taxes = base_cost + hst_amount + pst_amount + gst_amount
            end
          end
        end
    end
end