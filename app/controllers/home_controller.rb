class HomeController < ApplicationController
    
    def index
    	@orders = Order.where(:status => [Order::Status[:saved], Order::Status[:sent], Order::Status[:view]]).paginate(:page => params[:page], :per_page => 15)
    end

    def history
    	@orders = Order.where(:status => [Order::Status[:closed], Order::Status[:received], Order::Status[:deleted]]).paginate(:page => params[:page], :per_page => 15)
    end
    
end
  