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
		@products = Product.where(:status => Product::Status[:active], :category => Product::Categories[:stucco])
	end

	def edit
		@model = Model.find(params[:id])
		render :layout => false
	end

	def update
		@model = Model.find(params[:id])
		respond_to do |format|
			if @model.update(model_params)
				format.html { redirect_to builder_path(@model.builder_id), notice: 'Model was successfully updated.' }
				format.json { render :show, status: :ok, location: @model }
			else
				format.html { render :edit }
				format.json { render json: @model.errors, status: :unprocessable_entity }
			end
		end
	end

	def remove_model
	    if (params[:model][:id].blank?)
	        response = {success: false, data: "Missing parameters"}
	    else
	    	model_id = params[:model][:id]
			model = Model.find(model_id)
			if (model.blank?)
				response = {success: false, data: "Model not found!"}
			else
				model.update(:status => Model::Status[:inactive])
				response = {success: true, data: "Model removed successfully!"}
			end
	    end
	    render json: response, status: 200
	 end

	private

	def model_params
		params.require(:model).permit(:builder_id, :name, :photo, :status)
	end

end