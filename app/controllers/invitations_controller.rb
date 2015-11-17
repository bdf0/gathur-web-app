class InvitationsController < ApplicationController

  def new
  	@event = Event.find(params[:event_id])
  	@invitation = @event.invitations.new
  end
  
  def create
  end
  
  def destroy
  end
end
