class OrdersController < ApplicationController
	
	def show
		@order = Order.find(params[:id])
		model = Model.find(@order.lot_id)
		@model = model.name
	end

	def search_projects
		q = params[:q].to_s
    results = Project.select('projects.id, projects.name').where("projects.name ILIKE ?", "%#{q}%").limit(5).map { |project| {id: project.id, name: project.name} }
    render json: {success: true, data: results}, status: :ok
	end

	def search_lots
		project_id = params[:project_id].to_i
    results = Lot.select('lots.id, lots.number').where("lots.project_id = #{project_id}").limit(5).map { |lot| {id: lot.id, name: lot.number} }
    render json: {success: true, data: results}, status: :ok
	end

	def search_model
		if (params[:lot_id].blank?)
        response = {success: false, data: "Missing parameters"}
    else
			lot_id = params[:lot_id].to_i
			lot = Lot.find(lot_id)
			if lot.blank?
				response = {success: false, data: "Selected Lot not found!"}
			else
				model_id = lot.model_id
				model = Model.find(model_id)
				if model.blank?
					response = {success: false, data: "The selected lot does not have an associated model!"}
				else
					response = {success: true, model_name: model.name, model_id: model.id}
				end
			end
		end
		render json: response, status: 200
	end

	def create_order
		if (params[:order][:delivery_date].blank? or params[:order][:time_needed_by].blank? or params[:order][:project_id].blank? or params[:order][:lot_id].blank? or params[:order][:vendor_id].blank? or params[:order][:model_id].blank?)
			response = {success: false, data: "Missing parameters"}	
		else
      #Create a new order
      next_order_number = OrderNumbers.find(1)
      order = Order.new(order_params)
      if next_order_number.blank?
      	next_order_number = OrderNumbers.create(:order_number => 1)
      	next_order_number.save
      	order.order_number = 1
      	order.user_id = current_user.id
      else
      	next_order_number = OrderNumbers.find(1)
      	order.order_number = next_order_number.order_number
      	order.user_id = current_user.id
     	end

      if !order.save
        response = {success: false, data: "Server exception creating the new order"}
      else
      	vendor_id = params[:order][:vendor_id].to_i
      	vendor = Vendor.find(vendor_id)
      	order_total = 0
      	template = Template.where(:model_id => params[:order][:model_id])
      	template.each do |model|
      		product_vendor = vendor.product_vendors.where(:product_id => model.product_id, status: ProductVendor::Status[:active]).first
      		if !product_vendor.blank?
      			detail = OrderDetail.create(:order_id => order.id, :product_id => model.product_id, :quantity => model.quantity, :price => product_vendor.price, :total => (product_vendor.price * model.quantity))
      			order_total += (product_vendor.price * model.quantity)
      		end
      	end

      	order.update(order_total: order_total)
      	next_order_number.update(order_number: next_order_number.order_number + 1)

        response = {success: true, data: "Order created successfully!", order_id: order.id}
      end
		end
		render json: response, status: 200
	end

	private

  def order_params
      params.require(:order).permit(:delivery_date, :project_id, :time_needed_by, :lot_id, :status, :vendor_id, :notes, :user_id)
  end

end