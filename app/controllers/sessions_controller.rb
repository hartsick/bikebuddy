class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.where(:username => params[:session][:username]).first

		if @user == nil || !@user.authenticate(params[:session][:password])
			flash[:error] = "Invalid username/password combination."
			render 'new'
		else
			session[:remember_token] = @user.id
			@current_user = @user
			flash[:success] = "You're logged in!"
			redirect_to profile_path(@current_user)
			# cookies.permanent[:remember_token] = @user.id
		end
	end

	def destroy
		# cookies.permanent.delete(:remember_token)
		session.delete(:remember_token)
		redirect_to root_path
	end
end


