class AdminsController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin
	layout 'admins'

	def home
		@campuses = Campus.all
	end

	def authenticate_admin
		redirect_to root_path unless current_user.is_admin? 
	end
end
