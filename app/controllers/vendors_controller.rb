class VendorsController < ApplicationController

    def index
    	@vendors = Vendor.all
    end

    def new
        @vendor = Vendor.new
    end

    def edit
        @vendor = Vendor.find(params[:id])
    end

    def create
      #render plain: params[:article].inspect
      @vendor = Vendor.new(vendor_params)
      if @vendor.save
        redirect_to vendors_path
      else
        render 'vendors/new'
      end
    end

    def update
        @vendor = Vendor.find(params[:id])
        if @vendor.update(vendor_params)
            redirect_to vendor_path(@vendor)
        else
            render 'vendors/edit'
        end
    end

    def show
        @vendor = Vendor.find(params[:id])
    end

    def destroy
        #@article.destroy
        #flash[:danger] = "Article was successfully deleted"
        #redirect_to articles_path
    end

    private

    def vendor_params
        params.require(:vendor).permit(:name, :state, :address1, :zipcode, :address2, :phone, :city, :fax)
    end

end
  