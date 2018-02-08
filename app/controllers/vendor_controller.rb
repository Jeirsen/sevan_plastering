class VendorController < ApplicationController
    
    def index
    	@vendors = Vendor.all
    end
    
end
  