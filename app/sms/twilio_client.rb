class TwilioClient

  def initialize people, event
    @people = people
    @event = event
    account_sid = ENV['TWILIO_ACCOUNT_SID'] || 'AC6ef2afcab7f0748e9fc427288cdd5f8d'
    auth_token = ENV['PARAM1'] || ''

    # set up a client to talk to the Twilio REST API
    @account = Twilio::REST::Client.new(account_sid, auth_token).account
  end

  def deliver_all
    @people.each do |p|
      body = "A reminder from the Active Fire Plan Generator. "
      body += "'#{@event.name}' was triggered; you have #{p.tasks.where(event_id: @event).count} related tasks allocated."
      body += " Please check #{p.email}" if p.email
      # sms body can be up to 160 characters long
      @account.sms.messages.create({:from => '+19402028234', :to => p.mobile, :body => body[0..159]}) if Rails.env == 'production'
    end
  end

end