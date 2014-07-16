class SessionsController < ApplicationController

	def new
		 @user = User.new
	end

	def create
		logger.info "get token from api."

		token = authenticate(params[:email], params[:password])

		
		if token != nil 
			logger.info "Is a valid user. redirect to certifieds path."
			
			self.current_user = get_user(token)

			redirect_to certifieds_path, notice: 'Welcome.'
		else
			logger.info "is not a valid user. redirect to root path."

			redirect_to root_path, notice: 'User is not a valid eventick user.'
		end	
	end
	
	private

	def get_user(token)
		logger.info "Get user by token"

		user = User.where(token: token).first
		update = true if user == nil

		logger.info "If null try to get by email to update the token."

		user = User.where(email: params[:email]).first if user == nil
		user = User.new if user == nil

		if update
			logger.info "update parameters before save."

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
