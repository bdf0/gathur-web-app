class EventsController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

	def show
		@event = Event.find(params[:id])
	end
	
	def new
		@user = current_user
		@event = @user.events.new
	end
	
  def create
  	@user = current_user
    @event = @user.events.new(event_params)
    if @event.save
      flash[:success] = "Event Created"
      redirect_to @user
    else
      render 'new'
    end
  end
	
	private

    def event_params
      params.require(:event).permit(:title, :location, :start_time, :end_time, :description)
    end
	
end
