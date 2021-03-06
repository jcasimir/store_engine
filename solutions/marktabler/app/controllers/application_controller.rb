class ApplicationController < ActionController::Base
  protect_from_forgery

  def skip_mini_cart
    @skip_mini_cart = true
  end
  alias :skip_cart :skip_mini_cart
  alias :cu :current_user

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  helper_method :current_cart

  def not_authenticated
    flash[:warning] = "Please sign in to continue."
    redirect_to login_path
  end

  def require_admin
    return if current_user && current_user.admin?
    flash.notice = "You do not have admin rights!"
    redirect_to login_path
  end
end
