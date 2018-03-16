class ModelsController < ApplicationController

	def create
		if (params[:model][:name].blank? or params[:model][:builder_id].blank?)
        response = {success: false, data: "Missing parameters"}
    else
  		model = Model.new(model_params)
      if !model.save
        response = {success: false, data: "Server exception adding the new model"}
      else
       	response = {success: true, data: "Model added successfully!", model_id: model.id}
      end
    end
    render json: response, status: 200
	end

	def show
		@model = Model.find(params[:id])
	end

	private

	def model_params
		params.require(:model).permit(:name, :builder_id)
	end

end