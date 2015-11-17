class ApiEventsController < ApplicationController

	def find
		render :json =>  current_user.events
	end
	
	def new
		@event = current_user.events.create(event_params)
		render :json => @event
	end
	
	def update
		if current_user.events.exists? params[:id]
			@event = current_user.events.find(params[:id])
			@event.update_attributes(event_params)
		else
			@event = nil
		end
		
		render :json => @event
	end
	
	def destroy
		if current_user.events.exists? params[:id]
			@event = current_user.events.find(params[:id]).destroy
		else
			@event = nil
		end
		
		render :json => @event
	
	end
	
		private
		def current_user
			User.find_by('auth_token' => params[:auth])
		end
		
		def event_params
			params.permit(:title, :location, :start_time, :end_time, :description)
		end

end
