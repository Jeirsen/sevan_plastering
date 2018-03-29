class Admin::UsersController < AdminController

	def index
		@users = User.all
	end

	def show
		@user = User.find params[:id]
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		@user.password, @user.password_confirmation = @user.email
		if @user.save
			redirect_to admin_users_path, notice: 'User created'
		else
			render 'new'
		end
	end

	def edit
		@user = User.find params[:id]
	end

	def update
		@user = User.find params[:id]
		if @user.update_attributes user_params
			redirect_to admin_user_path(@user), notice: 'User updated'
		else
			render 'edit'
		end
	end

	private
	def user_params
		params.require(:user).permit(:email, :role, :first_name, :last_name)
	end
end