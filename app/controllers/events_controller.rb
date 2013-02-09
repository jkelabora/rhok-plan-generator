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
    # @event = Event.find(params[:id])
    # @task = @event.tasks.first
    # @person = @task.people.first
    # mailer = PersonMailer.welcome_email(@event, @person, @task)
    # @msg = mailer.deliver

    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)


    @account = @client.account
    @message = @account.sms.messages.create({:from => ENV['TWILIO_FROM'], :to => ENV['TWILIO_TO'], :body => 'rhok-and-roll!'})
    puts @message
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
