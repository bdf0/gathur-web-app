class ApiEventsController < ApplicationController

	def find
		render :json =>  current_user.events
	end
	
	def new
		@event = current_user.events.new(event_params)
		if @event.save
			render :json => @event
		else
			render :json => nil
		end
	end
	
	def update
		if current_user.events.exists? params[:event_id]
			@event = current_user.events.find(params[:event_id])
			@event.update_attributes(event_params)
		else
			@event = nil
		end
		
		render :json => @event
	end
	
	def destroy
		if current_user.events.exists? params[:event_id]
			@event = current_user.events.find(params[:event_id]).destroy
		else
			@event = nil
		end
		
		render :json => @event
	
	end
	
		private
		def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end
    
		def current_user
			authenticate_token
		end
		
		def event_params
			params.require(:title)
			params.require(:location)
			params.require(:start_time)
			params.require(:end_time)
			params.permit(:title, :location, :start_time, :end_time, :description)
		end

end
