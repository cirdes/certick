class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		
    #@user = User.new

    #@user.email = params[:email]
    #@user.password = params[:password]

    auth = Eventick::Auth.new
    #@auth.email = @user.email
		#@auth.password = @user.password


    redirect_to templates_path, notice: 'User was successfully created.'
  end
end
