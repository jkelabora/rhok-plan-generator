class PersonMailer < ActionMailer::Base
  default :from => "notifications@example.com"

    def welcome_email(person)
      @person = person
      @url  = "http://example.com/login"
      mail(:to => person.email, :subject => "Welcome to My Awesome Site")
    end
end
