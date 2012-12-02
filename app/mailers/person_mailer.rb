class PersonMailer < ActionMailer::Base
  default :from => "notifications@example.com"

    def welcome_email(event, person, task)
      @event = event
      @person = person
      @task = task
      @url  = "http://example.com/login"
      mail(:to => person.email, :subject => "Task '#{task.name}' needs to be performed. Reason: '#{event.name}'")
    end
end
