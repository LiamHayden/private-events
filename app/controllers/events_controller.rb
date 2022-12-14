class EventsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

  def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = current_user.created_events.build(event_params)

		if @event.save
			redirect_to root_path
		else
			render :new, status: :unprocessable_entity
		end

	end

	def show
		@event = Event.find(params[:id])
	end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path, status: :see_other
  end

	def rsvp
		@event = Event.find(params[:id])
		if @event.attendees.include?(current_user)
			redirect_to @event, notice: "You are already attending the event."
		else
			@event.attendees << current_user
			redirect_to @event, notice: "You are now attending the event."
		end
	end

  def cancel
    @event = Event.find(params[:id])

    @event.attendees.delete(current_user)
    redirect_to @event, notice: "You are no longer attending."
  end

	private
	def event_params
		params.require(:event).permit(:name, :location, :date, :creator_id)
	end
end
