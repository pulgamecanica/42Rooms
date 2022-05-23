class AdminsController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin
	layout 'admins'

	def home
		@reservations = Reservation.all.active.order(:starts_at)
	end

	def authenticate_admin
		redirect_to root_path unless current_user.is_admin? 
	end
end
