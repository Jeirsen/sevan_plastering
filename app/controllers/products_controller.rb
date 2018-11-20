class ProductsController < ApplicationController

	def index
  	@products = Product.where(:status => Product::Status[:active]).paginate(:page => params[:page], :per_page => 40)
    @active_products  = Product.where(:status => Product::Status[:active])
  end

	def admin_product
    if (params[:product][:name].blank? or params[:product][:unit_id].blank?)
        response = {success: false, data: "Missing parameters"}
    else
      if (params[:product][:id].to_i == 0 )
        #Create a new product
        product = Product.new(product_params)
        if !product.save
          response = {success: false, data: "Server exception adding the new product"}
        else
         	response = {success: true, data: "Product added successfully!", product_id: product.id}
        end
      else
        #Edit existing product
        product = Product.where(id: params[:product][:id]).first
        if (product.blank?)
          response = {success: false, data: "Product not found!"}
        else
          product.update(product_params)
          response = {success: true, data: "Product updated successfully!"}
        end
      end
    end
    render json: response, status: 200
  end

  def remove_product
    if(params[:id].blank?)
      response = {success: false, data: "Missing parameters"}
    else
      product_id = params[:id]
      product = Product.where(id: product_id).first
      if product.nil?
        response = {success: false, data: "Product not found!"}
      else
        product.update_attributes(:status => Product::Status[:inactive])
        response = {success: true, data: "Product removed successfully!"}
      end
    end
    render json: response, status: 200
  end

  def prioritize
    if(params[:product][:id].blank? or params[:product][:prioritize].blank?)
      response = {success: false, data: "Missing parameters"}
    else
      prioritize = params[:product][:prioritize]
      product_id = params[:product][:id].to_i
      product = Product.where(id: product_id).first
      if product.nil?
        response = {success: false, data: "Product not found!"}
      else
        product.update(product_params)
        response = {success: true, data: "Product updated successfully!"}
      end
    end
    render json: response, status: 200
  end

  def vip_products
    if(params[:product][:id].blank? or params[:product][:order_first_by].blank?)
      response = {success: false, data: "Missing parameters"}
    else
      position = params[:product][:order_first_by]
      product_id = params[:product][:id].to_i
      product = Product.where(id: product_id).first
      if product.nil?
        response = {success: false, data: "Product not found!"}
      else
        product.update(product_params)
        response = {success: true, data: "Product updated successfully!"}
      end
    end
    render json: response, status: 200
  end

  def search_products
    q = params[:q].to_s
    results = Product.select('products.id, products.name').where("products.name ILIKE ? AND products.status = #{Product::Status[:active]}", "%#{q}%").limit(5).map { |product| {id: product.id, name: product.name} }
    render json: {success: true, data: results}, status: :ok
  end

  private

  def product_params
      params.require(:product).permit(:id, :name, :unit_id, :status, :category, :prioritize, :order_first_by)
  end

end