class EventsController < ApplicationController
  def index
		@events = Event.all
	end

	def create
		@event = current_user.events.build(event_params)

		if @event.save?
			redirect_to root_path
		else
			render :new, status: :unprocessable_entity
		end

	end

	def show
		@event = Event.find(params[:id])
	end

	def rsvp
		@event = Event.find(params[:id])
		if @event.attendees.includes?(current_user)
			redirect_to @Event, notice: "You are already attending the event."
		else
			@event.attendees << current_user
			redirect_to @event, notice: "You are now attending the event."
		end
	end

	private
	def event_params
		params.require(:event).permit(:name, :location, :date)
	end
end
