class ApiMessagesController < ApplicationController

	def show
		@event = Event.find(params[:event_id])
			render :json =>  @event.messages
	end
	
	def new
		@event = Event.find(params[:event_id])
		@user = current_user
		@display_name = "#{@user.first_name} #{@user.last_name}"
		@message = @event.messages.new(display_name: @display_name, text: params[:text], user_id: current_user.id)
		if @message.save
			render :json => @message
		else
			render :json => nil
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
		
		def message_params
			params.require(:text)
			params.require(:event_id)
			params.permit(:text, :event_id)
		end

end
