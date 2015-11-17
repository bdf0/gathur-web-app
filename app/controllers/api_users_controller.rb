class ApiUsersController < ApplicationController
	require 'securerandom'
	
	VALID_TYPES = ['email', 'phone']
	VALID_PARAM_UPDATES = ['first_name', 'last_name', 'email', 'phone']
	
	def find
		if VALID_TYPES.include? params[:type]
			@user = User.find_by(params[:type] => params[:query])
		else
			@user = nil
		end
		
		render :json => secure_json(@user)
	end
	
	def current
		@user = User.find_by('auth_token' => params[:auth])
		render :json => @user
	end
	
	def update_authentication_token
		@user = User.find_by('email' => params[:email])
		if @user.authenticate(params[:password])
			set_auth_token(@user)
			render :json => @user.auth_token
		else
			render :json => nil
		end
	end
	
	def new
		@user = User.create(first_name: params[:first], last_name: params[:last], email: params[:email], phone: params[:phone], password: params[:password], password_confirmation: params[:password])
		set_auth_token(@user)
		render :json => @user
	end
	
	def update
		@user = User.find_by('auth_token' => params[:auth])
		params.each do |key, value|
			@user.update(key => value) if VALID_PARAM_UPDATES.include? key
		end
		
		render :json => @user
	end
	
	def destroy
		@user = User.find_by('auth_token' => params[:auth])
		render :json => @user.destroy
	end

	
	  private
    def set_auth_token(user)
      user.update(auth_token: SecureRandom.uuid.gsub(/\-/,''))
    end
    
    def secure_json(user)
    	user.as_json except: [:password_digest, :auth_token, :created_at, :updated_at, :admin, :remember_digest]
    end
		

end
