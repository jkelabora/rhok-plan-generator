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
    @task = @event.tasks.first
    @person = @task.people.first
    # mailer = PersonMailer.welcome_email(@event, @person, @task)
    # @msg = mailer.deliver

    @account_sid = 'AC6ef2afcab7f0748e9fc427288cdd5f8d'
    @auth_token = ENV['PARAM1']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)


    @account = @client.account
    @msg = @account.sms.messages.create({:from => '+19402028234', :to =>  @person.mobile, :body => 'rhok-and-roll!'})
    puts @msg
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
