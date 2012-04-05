class CartController < ApplicationController
  
  def index
     @products = current_cart.collect do |p,q|     
        [ q, Product.find(p) ]
     end     
  end

  def update
    id = params[:id]
    
    if not current_cart[id]
      current_cart[id] = 1
    else
      current_cart[id] += 1
    end

    save_json_cart
    redirect_to '/cart', :notice => "Item added."
  end

  private

  def current_cart
    load_json_cart
    @current_cart ||= {}
    save_json_cart
    @current_cart
  end

  def save_json_cart
    cookies[:cart] = @current_cart.to_json
  end

  def load_json_cart
    @current_cart = JSON.load(cookies[:cart])
  end

end
