class AdminController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :admin_only

  def admin_only
  	redirect_to root_path, notice: 'Admin only' if current_user.role != User::Roles[:admin]
  end


end
