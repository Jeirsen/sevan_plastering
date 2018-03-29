class Admin::SettingsController < AdminController

	def index
	end

	def edit
		@setting = OrderNumbers.find(params[:setting_id])
		render :layout => false
	end

	def update
		@setting = OrderNumbers.find params[:setting_id]
		@setting.order_number = params[:order_numbers][:order_number]

		respond_to do |format|
			if @setting.save
				format.html { redirect_to admin_settings_path, notice: 'Settings were successfully updated.' }
			else
				format.html { render :edit }
			end
		end
	end

	private
	def user_params
		params.require(:user).permit(:email, :role, :first_name, :last_name)
	end
end