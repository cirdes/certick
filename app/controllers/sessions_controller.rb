class SessionsController < ApplicationController

	def new
		 @user = User.new
	end

	def destroy
    self.current_user = nil
    redirect_to root_path
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

		update = true if user == nil

		user = User.where(email: params[:email]).first if user == nil
		user = User.new if user == nil

		if update
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
