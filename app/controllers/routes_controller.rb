class RoutesController < ApplicationController
  before_action :authenticate_user

	def index
		@routes = Route.all
	end

	def new
		@route = Route.new
	end

	def create
		@user = User.find(params[:id])
		@route = Route.new(route_params)
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
		# destroy all rides before destroying route
		@route = Route.find(params[:id])
		flash[:success] = "Route destroyed."
	end

	protected

	def route_params
		params.require(:route).permit(:name, :route_start, :route_end)
	end

end
