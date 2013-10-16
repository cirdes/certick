class SessionsController < ApplicationController

	def new
		 @user = User.new
	end

	def create
		
		token = authenticate(params[:email], params[:password])

		if token != nil 

			self.current_user = get_user(token)

			redirect_to certifieds_path, notice: 'Welcome.'
		else
			redirect_to root_path, notice: 'User is not a valid eventick user.'
		end	
	end
	
	private

	def get_user(token)
		
		user = User.where(token: token).first
		if user == nil
			user = User.new 

			user.email = params[:email]
			user.token = token

			user.save
		end	
		user
	end	

	def authenticate(email, password)
		 SimpleEventickApi::Auth.authenticate email, password
		 
	end	

end
