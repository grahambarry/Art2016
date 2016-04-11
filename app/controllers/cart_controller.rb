class CartController < ApplicationController
def add
	# get the ID of the product
	id = params[:id]
	# if the cart has already been created, use the existing cart
	# else create a blank cart
	if session[:cart] then
		cart = session[:cart]
	else
		session[:cart] = {}
		cart = session[:cart]
	end
	# if the product has alreadd been added to the cart, increment the value
	# else set the value to 1
	if cart[id] then
		cart[id] = cart[id] + 1
	else
		cart[id] = 1
	end
	# redirect to the cart display page
	redirect_to :action => :index
	end #end add method 
def clearCart
	# set the session variable to nil and redirect
	session[:cart] = nil
	redirect_to :action => :index
	end
def index
	@pins = Pin.all
	# if there is a cart, pass it to the page for display
	# else pass an empty value
	if session[:cart] then
		@cart = session[:cart]
	else
		@cart = {}
	end
end
end