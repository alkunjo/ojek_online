class Api::UsersController < Api::ApplicationController

	def all
		@users = User.all
		render json: @users
	end

	def single
		@user = User.find_by_uuid(params[:uuid])
		render json: @user
	end
end