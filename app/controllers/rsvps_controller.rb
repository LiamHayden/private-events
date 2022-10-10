class RsvpsController < ApplicationController
	def rsvp
		@event = Event.find(params[:id])
		if @event.attendees.includes?(current_user)
			redirect_to @Event, notice: "You are already attending the event."
		else
			@event.attendees << current_user
			redirect_to @event, notice: "You are now attending the event."
		end
	end
end
