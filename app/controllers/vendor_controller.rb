class VendorController < ApplicationController
    
    def index
    	@vendors = Vendor.all
    end

    def new
        @vendor = Vendor.new
    end

    def edit
        
    end

    def create
      #render plain: params[:article].inspect
      @vendor = Vendor.new(vendor_params)
      if @vendor.save
        flash[:success] = "Vendor was successfully created!!"
        redirect_to list_vendors_path
      else
        render 'new'
      end
    end

    def update
        #if @article.update(article_params)
            #flash[:success] = "Article was successfully updated!!"
            #redirect_to article_path(@article)
        #else
            #render 'edit'
        #end
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
  