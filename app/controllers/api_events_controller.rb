class ApiEventsController < ApplicationController

	def find
		render :json =>  current_user.events
	end
	
	def new
		@event = current_user.events.new(event_params)
		creator = User.find(@event.user_id)
		name = "#{creator.first_name} #{creator.last_name}"
		@event.update(creator_name: User.find(@event.user_id))
		if @event.save
			render :json => @event
		else
			head 400
		end
	end
	
	def update
		if current_user.events.exists? params[:event_id]
			@event = current_user.events.find(params[:event_id])
			@event.update_attributes(event_params)
			render :json => @event
		else
			head 400
		end	
	end
	
	def all
		render :json => Event.all
	end
	
	def destroy
		if current_user.events.exists? params[:event_id]
			@event = current_user.events.find(params[:event_id]).destroy
			render :json => @event
		else
			head 400
		end
		
		
	
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
