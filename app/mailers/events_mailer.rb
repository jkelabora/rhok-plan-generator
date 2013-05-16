class EventsMailer

  def initialize people, event
    @people = people
    @event = event
    @service = AWS::SimpleEmailService.new(
      # these two env var *names* are preset by Elastic Beastalk and have been given values via the AWS Console
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_KEY']) 
  end

  def deliver_all
    @people.each do |p|

      subject = "Active Fire Plan Generator reminder: "
      subject += "'#{@event.name}' was triggered; you have #{p.tasks.where(event_id: @event).count} related tasks allocated."

      body_text = "Hi #{p.name.capitalize},\n"
      body_text += "We're sending you this email as a reminder "
      body_text += "of the #{p.tasks.where(event_id: @event).count} tasks "
      body_text += "you have allocated to you in your Fire Plan in relation to '#{@event.name}'.\n"
      body_text += "The tasks are:\n"
      p.tasks.where(event_id: @event).each {|t| body_text += "- #{t.name}\n"}
      body_text += "\n\nHope that helps,\nBest regards,\nThe Active Fire Plan Generator team"

      @service.send_email(
        :subject => subject,
        :from => 'jkelabora@dius.com.au', # ses verified sender address
        :to => p.email,
        :body_text => body_text,
        :body_html => body_text) if Rails.env == 'production'
    end
  end

end