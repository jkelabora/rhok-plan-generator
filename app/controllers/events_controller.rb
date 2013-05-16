class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @people = @event.tasks.collect(&:people).flatten.uniq # TODO: THIS IS INEFFICIENT!

    EventsMailer.new(@people, @event).deliver_all

    account_sid = 'AC6ef2afcab7f0748e9fc427288cdd5f8d'
    auth_token = ENV['PARAM1']

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new(account_sid, auth_token)
    account = client.account

    @people.each do |p|
      body = "A reminder from the Active Fire Plan Generator. "
      body += "'#{@event.name}' was triggered; you have #{p.tasks.where(event_id: @event).count} related tasks allocated."
      body += " Please check #{p.email}" if p.email
      # sms body can be up to 160 characters long
      @msg = account.sms.messages.create({:from => '+19402028234', :to => p.mobile, :body => body[0..159]}) if Rails.env == 'production'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end
end
