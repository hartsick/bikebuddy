class UsersController < ApplicationController
	before_action :authenticate_user, except: [:new, :create]

	def profile
		@user = User.find(session[:remember_token])
		@rides = @user.rides
		@followed_rides = Ride.where(:user => @user)
		@routes = @user.routes
	end

	def show
		@user = User.find(params[:id])
		# @rides = Ride.find(params[:user_id])
	end

	def index
		@users = User.all
	end

	def new 
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome! Your account was created successfully."

			# log 'em in
			session[:remember_token] = @user.id
			@current_user = @user
			redirect_to profile_path(@user)
		else
			render 'new'
		end
	end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username, :name, :email, :phone))
    	flash[:success] = "Your account has been updated."
      redirect_to profile_path(@user)
    else
      render 'edit'
    end
  end

	def destroy
		# TO DO: delete associated route instances if not associated with any other users
		@user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Your account has been deleted."
		session.clear
		redirect_to new_sessions_path
	end

	protected

	def user_params
			params.require(:user).permit(:username, :name, :email, :password, :phone)
	end
end
