class HomeController < ApplicationController
    
    def index
    	@orders = Order.all
    end
    
end
  