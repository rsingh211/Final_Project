class OrdersController < ApplicationController
    before_action :authenticate_user!
  
    def index
        @orders = current_user.orders.includes(:order_items, :beats) # assuming user has_many :orders
    end
    def checkout
        redirect_to new_user_session_path unless user_signed_in?
        # render the logged-in user checkout page
      end
      
      def create
        # Create order using current_user.id
      end
      
  end
  