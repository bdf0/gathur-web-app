class ApiInvitationsController < ApplicationController

	def new
		@event = current_event
		if @event && params[:phone]
			@invited_user = User.find_by(phone: params[:phone])
			@invitation = current_event.invitations.create(user_id: @invited_user.id)
			@invitation.update(accepted: false)
			@invitation.update(display_name: "#{@invited_user.first_name} #{@invited_user.last_name}")
			@invitation.update(event_name: @invitation.event.title)
		elsif @event && params[:email]
			@invited_user = User.find_by(email: params[:email])
			@invitation = current_event.invitations.create(user_id: @invited_user.id)
			@invitation.update(accepted: false)
			@invitation.update(display_name: "#{@invited_user.first_name} #{@invited_user.last_name}")
			@invitation.update(event_name: @invitation.event.title)
			render :json => @invitation

		else
			head 400
		end
		

	end
	
	def toggle
		@event = Event.find(params[:event_id])
		unless @event
			head 400
			return
		end
		
		@user = current_user
		@invitation = Invitation.find_by(user_id: current_user.id, event_id: @event.id)
		
		if @invitation
			@invitation.update(accepted: !@invitation.accepted) 
		elsif @event.public
				@invited_user = current_user
				@invitation = current_event.invitations.create(user_id: @invited_user.id)
				@invitation.update(accepted: true)
				@invitation.update(display_name: "#{@invited_user.first_name} #{@invited_user.last_name}")
				@invitation.update(event_name: @invitation.event.title)
		else
			head 400
			return
		end
		
		render :json => @invitation
		
	end

	def show
		@event = Event.find(params[:event_id])
		@invitations = @event.invitations
		if @invitations.include? Invitation.find_by(user_id: current_user.id, event_id: @event.id) or current_user.events.include? @event
			#render :json => @invitations
			render :json => @invitations.where(accepted: true)
		else
			render :json => nil
		end
	end
	
	def show_events
		@user = current_user
		@invitations = @user.invitations
		@events = []
		@invitations.each do |invitation|
			@events.push invitation.event
		end
		
		render :json => @events
		
	end
	
	def mine
		render :json => current_user.invitations
	end
	
	def my_accepted
		@events = []
		@invitations = current_user.invitations.where(accepted: true)
		@invitations.each do |inv|
			@events << inv.event
		end
		
		render :json => @events
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
		event = Event.find(params[:event_id])
		if current_user.events.exists? params[:event_id]
			current_user.events.find(params[:event_id])
		elsif event.public
			event
		else
		
			nil
		end
	end

end
