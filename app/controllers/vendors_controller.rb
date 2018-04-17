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

    def vendor_email
      if (params[:vendor_email][:name].blank? or params[:vendor_email][:description].blank? or params[:vendor_email][:email].blank? or params[:vendor_email][:vendor_id].blank?)
          response = {success: false, data: "Missing parameters"}
      else
        if (params[:vendor_email][:id].to_i == 0 )
          #Create a new vendor email
          vendor_email = VendorEmail.where(email: params[:vendor_email][:email], vendor_id:params[:vendor_email][:vendor_id]).first
          if (vendor_email.blank?)
            email = VendorEmail.new(vendor_email_params)
            if !email.save
              response = {success: false, data: "Server exception adding the new vendor email"}
            else
              response = {success: true, data: "Vendor email added successfully!"}
            end
            
          else
            response = {success: false, data: "The email #{vendor_email.email} is already registered!"}
          end
        else
          #Edit existing vendor email
          vendor_email = VendorEmail.where(id: params[:vendor_email][:id]).first
          if (vendor_email.blank?)
            response = {success: false, data: "Vendor email not found!"}
          else
            email = VendorEmail.where(email: params[:vendor_email][:email], vendor_id:params[:vendor_email][:vendor_id]).first
            if (email.blank?)
              vendor_email.update(vendor_email_params)
              response = {success: true, data: "Vendor email updated successfully!"}
            else
              if (vendor_email.id != email.id)
                response = {success: false, data: "The email #{vendor_email.email} is already registered!"}
              else
                vendor_email.update(vendor_email_params)
                response = {success: true, data: "Vendor email updated successfully!"}
              end
            end
          end

        end
      end
      render json: response, status: 200
    end

    def vendor_product
      if (params[:vendor_product][:vendor_id].blank? or params[:vendor_product][:product_id].blank? or params[:vendor_product][:price].blank?)
          response = {success: false, data: "Missing parameters"}
      else
        if (params[:vendor_product][:id].to_i == 0 )
          #Add new product to vendor
          product_vendor = ProductVendor.where(vendor_id: params[:vendor_product][:vendor_id], product_id: params[:vendor_product][:product_id],).first
          if (product_vendor.blank?)
            product_vendor = ProductVendor.new(vendor_product_params)
            if !product_vendor.save
              response = {success: false, data: "Server exception adding the new product vendor"}
            else
              response = {success: true, data: "Product added successfully!", id: product_vendor.id}
            end
            
          else
            response = {success: false, data: "This product is already registered to this vendor!"}
          end
        else
          #Edit existing vendor product
          product_vendor = ProductVendor.where(id: params[:vendor_product][:id]).first
          if (product_vendor.blank?)
            response = {success: false, data: "Vendor product not found!"}
          else
            product_vendor.update(vendor_product_params)
            response = {success: true, data: "Vendor product updated successfully!"}
          end
        end
      end
      render json: response, status: 200
    end

    private

    def vendor_params
        params.require(:vendor).permit(:name, :state, :address1, :zipcode, :address2, :phone, :city, :fax)
    end

    def vendor_email_params
        params.require(:vendor_email).permit(:name, :description, :email, :status, :vendor_id)
    end

    def vendor_product_params
        params.require(:vendor_product).permit(:product_id, :vendor_id, :status, :price)
    end

end
  