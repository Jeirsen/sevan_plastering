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

  def add_order_item
    if (params[:order_detail][:order_id].blank? or params[:order_detail][:product_id].blank? or params[:order_detail][:quantity].blank? or params[:order_detail][:price].blank? or params[:order_detail][:total].blank?)
      response = {success: false, data: "Missing parameters"} 
    else
      #Add new item to the order
      order_detail = OrderDetail.new(order_detail_params)
      if !order_detail.save
          response = {success: false, data: "Server exception adding the new item to the order"}
      else
        order_total = 0
        order_id = params[:order_detail][:order_id].to_i
        order = Order.find(order_id)
        full_order_detail = OrderDetail.where(:order_id => order_id)
        full_order_detail.each do |item|
          order_total = order_total + item.total
        end
        order.update(order_total: order_total)
        response = {success: true, data: "Item added successfully!", order_detail_id: order_detail.id, order_total: order_total}
      end
    end
    render json: response, status: 200
  end

  def edit_order_item
    if (params[:order_detail][:id].blank? or params[:order_detail][:quantity].blank? or params[:order_detail][:price].blank? or params[:order_detail][:total].blank?)
      response = {success: false, data: "Missing parameters"} 
    else
      #Edit item to the order
      order_item_id = params[:order_detail][:id].to_i
      order_detail = OrderDetail.find(order_item_id)
      if (order_detail.blank?)
        response = {success: false, data: "Order item not found!"}
      else
        order_detail.update_attributes(update_item_order_params)
        order_total = 0
        order_id = order_detail.order_id
        order = Order.find(order_id)
        full_order_detail = OrderDetail.where(:order_id => order_id)
        full_order_detail.each do |item|
          order_total = order_total + item.total
        end
        order.update(order_total: order_total)
        response = {success: true, data: "Item updated successfully!", order_total: order_total}
      end
    end
    render json: response, status: 200
  end

  def send_mail
    @order = Order.find params[:id].to_i
    begin
      OrderMailer.send_to_vendor(@order).deliver_now 
      response = {success: true, data: "Mail sent successfully!"}
      @order.update(:status => Order::Status[:sent])
    rescue Exception => e
      response = {success: false, data: "Mail error exception!"}
    end
    render json: response, status: 200
  end

  def remove_item
    if (params[:id].blank?)
        response = {success: false, data: "Missing parameters"}
    else
      order_item_id = params[:id].to_i
      order_detail = OrderDetail.find(order_item_id)
      if (order_detail.blank?)
        response = {success: false, data: "Order item not found!"}
      else
        order_id = order_detail.order_id
        order_detail.destroy
        order_total = 0
        order = Order.find(order_id)
        full_order_detail = OrderDetail.where(:order_id => order_id)
        full_order_detail.each do |item|
          order_total = order_total + item.total
        end
        order.update(order_total: order_total)
        response = {success: true, data: "Item removed successfully!", order_total: order_total}
      end
    end
    render json: response, status: 200
  end

	private

  def order_params
      params.require(:order).permit(:delivery_date, :project_id, :time_needed_by, :lot_id, :status, :vendor_id, :notes, :user_id)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :product_id, :quantity, :price, :total)
  end

  def update_item_order_params
    params.require(:order_detail).permit(:quantity, :price, :total)
  end

end