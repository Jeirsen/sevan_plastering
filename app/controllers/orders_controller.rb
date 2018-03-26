class OrdersController < ApplicationController
	
	def show
		@order = Order.find(params[:id])
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

end