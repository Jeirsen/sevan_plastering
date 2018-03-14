class UnitsController < ApplicationController

	def index
		@units = Unit.all
	end

	def admin_unit
		if (params[:unit][:name].blank?)
        response = {success: false, data: "Missing parameters"}
    else
      if (params[:unit][:unit_id].to_i == 0 )
        #Create a new unit
        unit_name = Unit.where(:name => params[:unit][:name]).first
        if unit_name.blank?
        	unit = Unit.new(unit_params)
        	if !unit.save
          	response = {success: false, data: "Server exception adding the new product"}
        	else
         		response = {success: true, data: "Unit added successfully!", unit_id: unit.id}
        	end
        else
        	response = {success: false, data: "Unit name already exists in the database, please try another."}
        end
      else
        #Edit existing unit
        unit = Unit.where(id: params[:unit][:unit_id]).first
        if (unit.blank?)
          response = {success: false, data: "Unit not found!"}
        else
        	unit_name = Unit.where(:name => params[:unit][:name]).first
        	if unit_name.blank?
          	unit.update(unit_params)
          	response = {success: true, data: "Unit updated successfully!"}
          else
          	response = {success: false, data: "Unit name already exists in the database, please try another."}	
          end
        end
      end
    end
    render json: response, status: 200
	end

	private
  def unit_params
      params.require(:unit).permit(:name)
  end

end