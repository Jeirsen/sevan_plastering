class TemplatesController < ApplicationController

	def template_product
    if (params[:template][:model_id].blank? or params[:template][:product_id].blank? or params[:template][:quantity].blank?)
        response = {success: false, data: "Missing parameters"}
    else
      if (params[:template][:id].to_i == 0 )
        #Add new product to template
        product_template = Template.where(model_id: params[:template][:model_id], product_id: params[:template][:product_id]).first
        if (product_template.blank?)
          product_template = Template.new(template_params)
          if !product_template.save
            response = {success: false, data: "Server exception adding the new product to the template"}
          else
            response = {success: true, data: "Product added successfully!", id: product_template.id, unit_name: product_template.product.unit.name}
          end
        else
          product_template.update_attributes(:quantity => params[:template][:quantity])
          response = {success: true, data: "This product is already registered to this template!"}
        end
      else
        #Edit existing template product
        product_template = Template.where(id: params[:template][:id]).first
        if (product_template.blank?)
          response = {success: false, data: "Product template not found!"}
        else
          product_template.update(template_params)
          response = {success: true, data: "Template product updated successfully!", unit_name: product_template.product.unit.name}
        end
      end
    end
    render json: response, status: 200
  end

  def remove_template_product
    if (params[:template][:id].blank?)
        response = {success: false, data: "Missing parameters"}
    else
      product_template = Template.where(id: params[:template][:id]).first
      if (product_template.blank?)
        response = {success: false, data: "Product template not found!"}
      else
        product_template.destroy
        response = {success: true, data: "Template product removed successfully!"}
      end
    end
    render json: response, status: 200
  end

  private

  def template_params
  	params.require(:template).permit(:product_id, :model_id, :quantity)
  end


end