class RidesController < ApplicationController
  before_action :authenticate_user

	def index
		@user = User.find(session[:remember_token])
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
		@user = User.find(session[:remember_token])
		@route = Route.find(params[:route_id])
		@ride = Ride.new(ride_params)

		@ride.route = @route
		@ride.created_by = session[:remember_token]

		# add user to route
		@ride.users << @user
		@user.save

		if @ride.save
			flash[:success] = "Ride created successfully."
			redirect_to route_rides_path(@route)
		else
			render 'new'
		end
	end

	def show
		# TO DO: fix weirdness with route_id vs id
		@ride = Ride.find(params[:route_id])
		@user = User.find(session[:remember_token])
		@users = User.where(:ride_ids => @ride.id)
	end

	def edit
		@ride = Ride.find(params[:route_id])
	end

	def update
		@ride = Ride.find(params[:id])
		if @ride.update(ride_params)
			flash[:success] = "Ride updated successfully."
			redirect_to route_rides_path(@ride.route)
		else
			render 'edit'
		end
	end

	def follow
		@user = User.find(session[:remember_token])
		@ride = Ride.find(params[:id])
		@ride.users << @user
		@user.rides << @ride

		if @user.save
			flash[:success] = "User route saved."
		end
		
		if @ride.save
			flash[:success] = "You are now following this route."
			redirect_to route_rides_path(@ride.route)
		end
	end

	def unfollow
		@user = User.find(session[:remember_token])
		@ride = Ride.find(params[:id])
		@ride.users.delete_all(id: @user.id)

		@user.save

		if @ride.save
			flash[:success] = "You are no longer following this route."
		end
	end

	def destroy
		@ride = Ride.find(params[:id])
		@route = @ride.route
    @ride.destroy
		redirect_to route_rides_path(@route)
	end

	protected

	def ride_params
		params.require(:ride).permit(:name, :difficulty, :start_time_hour, :start_time_min, :start_time_am, :frequency, :meeting_points, :ride_admin, :ride_creator)
	end
end
