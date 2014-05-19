class RoutesController < ApplicationController
  before_action :authenticate_user, except: [:index]

	def index
		@routes = Route.all
	end

	def new
		@route = Route.new
	end

	def create
		@user = User.find(session[:remember_token])
		@route = Route.new(route_params)

		@route.user = @user

		if @route.save 
			flash[:success] = "Route created successfully."
			redirect_to routes_path
		else
			render :new
		end
	end

	def show
		@route = Route.find(params[:id])
		@rides = Ride.where(:route_id => params[:id])
	end

	def edit
		@route = Route.find(params[:id])
	end

	def update
		@route = Route.find(params[:id])

		if @route.update(route_params)
			flash[:success] = "Route updated successfully."
			redirect_to routes_path
		else
			render 'edit'
		end
	end

	def destroy
		@route = Route.find(params[:id])
		@route.rides.delete_all
		@route.destroy
		flash[:success] = "Route destroyed."
	end

	protected

	def route_params
		params.require(:route).permit(:name, :route_start, :route_end)
	end

end
