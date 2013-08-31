class EventsController < ApplicationController

  def trigger
    @event = Event.find(params[:event_id])
    @people = @event.tasks.collect(&:people).flatten.uniq # TODO: THIS IS INEFFICIENT!
    EventsMailer.new(@people, @event).deliver_all
    TwilioClient.new(@people, @event).deliver_all
  end

end
