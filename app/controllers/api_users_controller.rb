class ApiUsersController < ApplicationController
	require 'securerandom'
	
	VALID_TYPES = ['email', 'phone', 'user_id']
	VALID_PARAM_UPDATES = ['first_name', 'last_name', 'email', 'phone']
	
	def find
		if authenticate_token and VALID_TYPES.include? params[:type]
		@user = User.find_by(params[:type] => params[:query])
		else
			@user = nil
		end
		
		render :json => secure_json(@user)
	end
	
	def current
		@user = authenticate_token
		render :json => @user
	end
	
	def create_authentication_token
		@user = User.find_by('email' => params[:email])
		if @user and @user.authenticate(params[:password])
			set_auth_token(@user)
			render :json => [token: @user.auth_token]
		else
			render :json => nil
		end
	end
	
	def get_authentication_token
		@user = User.find_by('email' => params[:email])
		if @user and @user.authenticate(params[:password])
			if @user.auth_token.nil?
				set_auth_token(@user)
			end
			render :json => [token: @user.auth_token]
		else
			render :json => nil
		end
	end
	
	def new
		@user = User.new(new_user_params) 
		if @user.save
				set_auth_token(@user)
		else
			@user = nil
		end
		
		render :json => api_json(@user)
	end
	
	def update
		@user = authenticate_token
		params.each do |key, value|
			@user.update(key => value) if VALID_PARAM_UPDATES.include? key
		end
		
		render :json => api_json(@user)
	end
	
	def destroy
		@user = authenticate_token
		render :json => @user.destroy
	end

	
	  private
	  def new_user_params
	  	params.require(:first_name)
	  	params.require(:last_name)
	  	params.require(:email)
	  	params.require(:phone)
	  	params.require(:password)
	  	params.permit(:first_name, :last_name, :email, :password, :phone)
	  end
	  
	  def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end
	  
    def set_auth_token(user)
      user.update(auth_token: SecureRandom.uuid.gsub(/\-/,''))
    end
    
    def secure_json(user)
    	user.as_json except: [:password_digest, :auth_token, :created_at, :updated_at, :admin, :remember_digest]
    end
    
    def api_json(user)
    	user.as_json except: [:password_digest, :remember_digest]
    end
		

end
