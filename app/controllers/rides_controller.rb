class RidesController < ApplicationController
  before_action :authenticate_user


	def index
		@route = Route.find(params[:route_id])
		@rides = Ride.where(:route_id  => params[:route_id])
	end

	def new
		@ride = Ride.new
		# if currently in route, grab route info
		if params[:route_id]
			@route = Route.find(params[:route_id])
		else
			@route = Route.new
		end
		@routes = Route.all
	end

	def create
		@route = Route.find(params[:route_id])
		@ride = Ride.new(ride_params)
		@ride.route_id = params[:route_id]

		if @ride.save
			flash[:success] = "Ride created successfully."
			redirect_to route_rides_path(@route)
		else
			render 'new'
		end
	end

	def show
		@ride = Ride.find(params[:route_id])
		@route = Route.find(params[:id])
	end

	def edit
		@ride = Ride.find(params[:id])
	end

	def update
		@ride = Ride.find(params[:id])
		if @ride.update(ride_params)
			flash[:success] = "Ride updated successfully."
			render route_rides_path
		else
			render 'edit'
		end
	end

	def destroy
		@ride = Ride.find(params[:id])
		@route = Route.find(@ride.route_id)
    @ride.destroy
    flash[:success] = "Ride has been deleted."
		redirect_to route_rides_path(@route)
	end

	protected
	def ride_params
		params.require(:ride).permit(:name, :difficulty, :start_time_hour, :start_time_min, :start_time_am, :frequency, :meeting_points, :ride_admin, :ride_creator, :route_id)
	end
end
