class ContactMailer < ApplicationMailer
  def contact_details(name, email, subject, message)
    @name = name
    @sender = email
    subject = subject
    @message = message
    if @sender
      mail(subject: subject)
    end
  end
end