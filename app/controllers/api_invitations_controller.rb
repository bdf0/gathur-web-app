class ApiInvitationsController < ApplicationController

	def new
		if current_event && params[:phone]
			@invited_user = User.find_by(phone: params[:phone])
			@invitation = current_event.invitations.create(user_id: @invited_user.id)
			@invitation.update(accepted: false)
			@invitation.update(display_name: "#{@invited_user.first_name} #{@invited_user.last_name}")
		elsif current_event && params[:email]
			@invited_user = User.find_by(email: params[:email])
			@invitation = current_event.invitations.create(user_id: @invited_user.id)
			@invitation.update(accepted: false)
			@invitation.update(display_name: "#{@invited_user.first_name} #{@invited_user.last_name}")
		else
			@invitation = nil
		end
		
		render :json => @invitation
	end
	
	def toggle
		@event = Event.find(params[:event_id])
		@invitation = Invitation.find_by(user_id: current_user.id, event_id: @event.id)
		@invitation.update(accepted: !@invitation.accepted) unless @invitation.nil?
		
		render :json => @invitation
	end

	def show
		@event = Event.find(params[:event_id])
		@invitations = @event.invitations
		if @invitations.include? Invitation.find_by(user_id: current_user.id, event_id: @event.id) or current_user.events.include? @event
			render :json => @invitations
		else
			render :json => nil
		end
	end
	
	def mine
		render :json => current_user.invitations
	end
	
	def destroy
		@invitation = Invitation.find(params[:inv_id])
		if @invitation.event.user_id == current_user.id
			render :json => @invitation.destroy
		elsif @invitation.user_id == current_user.id
			render :json => @invitation.destroy
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
	
	def current_event
		if current_user.events.exists? params[:event_id]
			current_user.events.find(params[:event_id])
		else
			nil
		end
	end

end
