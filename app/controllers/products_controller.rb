class ProductsController < ApplicationController

	def index
  	@products = Product.where(:status => Product::Status[:active]).paginate(:page => params[:page], :per_page => 4)
  end

  

end