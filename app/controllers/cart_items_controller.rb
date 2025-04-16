class CartItemsController < ApplicationController
  def index
    session[:cart] ||= {}

    # Convert string keys to integers for Beat lookup
    beat_ids = session[:cart].keys.map(&:to_i)

    # Find existing beats
    @beats = Beat.where(id: beat_ids)

    # Remove deleted beats from cart
    valid_ids = @beats.pluck(:id).map(&:to_s)
    session[:cart].slice!(*valid_ids)

    # Calculate total price
    @total_price = @beats.sum do |beat|
      quantity = session[:cart][beat.id.to_s]
      beat.price * quantity
    end
    @total_price = @total_price.round(2)
    @total_price = sprintf('%.2f', @total_price)
    @total_price = @total_price.sub(/\.0$/, '') # Remove trailing .0 if present
    @total_price = @total_price.sub(/\.00$/, '') # Remove trailing .00 if present
    @total_price = @total_price.sub(/\.0+$/, '') # Remove trailing .0 or .00 if present
  end

  def create
    session[:cart] ||= {}
    beat_id = params[:beat_id].to_s

    session[:cart][beat_id] ||= 0
    session[:cart][beat_id] += 1

    redirect_back fallback_location: beats_path, notice: "Beat added to cart!"
  end

  def update_quantity
    session[:cart] ||= {}
    beat_id = params[:beat_id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][beat_id] = quantity
    else
      session[:cart].delete(beat_id)
    end

    redirect_to cart_path, notice: "Cart updated."
  end

  def destroy
    session[:cart] ||= {}
    session[:cart].delete(params[:id].to_s)

    redirect_to cart_path, notice: "Item removed from cart."
  end
end
